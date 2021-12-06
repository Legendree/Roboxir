defmodule Roboxir.Parser do
  alias Roboxir.{UserAgent, Store}

  def parse_data(url) do
    Store.flush()
    url = url <> "/robots.txt"

    {:ok, {_status, _headers, body}} = :httpc.request(:get, {url, []}, [], [])

    {:ok, active_agent} = Agent.start_link(fn -> nil end)
    :global.register_name(:current_agent, active_agent)
    IO.iodata_to_binary(body) |> String.split("\n") |> Enum.each(&match_line/1)
    :ok
  end

  defp match_line("User-Agent: " <> name) do
    set_agent(name)
    Store.add_agent(%UserAgent{name: name})
  end

  defp match_line("User-agent: " <> name) do
    set_agent(name)
    Store.add_agent(%UserAgent{name: name})
  end

  defp match_line("user-agent: " <> name) do
    set_agent(name)
    Store.add_agent(%UserAgent{name: name})
  end

  defp match_line("Crawl-delay: " <> delay) do
    delay = delay |> String.to_integer()
    current_agent = current_agent()
    Store.add_delay(current_agent, delay)
  end

  defp match_line("Disallow: " <> path) do
    current_agent = current_agent()
    Store.add_disallowed_path(current_agent, path)
  end

  defp match_line("Allow: " <> path) do
    current_agent = current_agent()
    Store.add_allowed_path(current_agent, path)
  end

  defp match_line("Sitemap: " <> path) do
    current_agent = current_agent()
    Store.add_sitemap_path(current_agent, path)
  end

  defp match_line(_), do: :skip

  defp current_agent,
    do: Agent.get(:global.whereis_name(:current_agent), fn agent_name -> agent_name end)

  defp set_agent(agent_name),
    do: Agent.update(:global.whereis_name(:current_agent), fn _ -> agent_name end)
end
