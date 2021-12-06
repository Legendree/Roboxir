defmodule Roboxir do
  @moduledoc """
  Roboxir is a straightforward Robots.txt parser that lets you know if the crawler with specified name
  is legable to crawl a website. This parser has two functions, crawlable/2 and crawlable?/2
  """
  alias Roboxir.{UserAgent, Store, Parser}

  @doc """
  Checks if a user-agent is legable to crawl the website, returns
  true if the agent can crawl the page, false otherwise.

  ## Examples

      iex> Roboxir.crawlable?("your_agent_name", "https://google.com/")
      true
  """
  @spec crawlable?(String.t(), String.t()) :: boolean()
  def crawlable?(agent_name, url) do
    Parser.parse_data(url)
    _crawlable?(agent_name)
  end

  @doc """
  Simillarly to `crawlable?/2` parses the robots.txt on the desired website,
  returns a Struct which can be used to determine the allowed/disallowed url paths per agent.

  ## Examples

      iex> user_agent = Roboxir.crawlable("some_random_agent", "https://google.com/")
      %Roboxir.UserAgent{
        allowed_urls: ["/js/", "/finance", "/maps/reserve/partners", "/maps/reserve",
         "/searchhistory/", "/alerts/$", "/alerts/remove", "/alerts/manage",
         "/accounts/o8/id", "/s2/static"],
        delay: 0,
        disallowed_urls: ["/nonprofits/account/", "/localservices/*", "/local/tab/",
         "/local/place/rap/", "/local/place/reviews/"],
        name: "google",
        sitemap_urls: []
      }

      iex> user_agent = Roboxir.crawlable("some_random_agent", "https://google.com/")
      iex> user_agent.disallowed_urls
      ["/nonprofits/account/", "/localservices/*", "/local/tab/", "/local/place/rap/",
       "/local/place/reviews/", "/local/place/products/", "/local/dining/",
       "/local/dealership/", "/local/cars/", "/local/cars", "/intl/*/about/views/",
       "/about/views/"]
  """
  @spec crawlable(String.t(), String.t()) :: UserAgent.t()
  def crawlable(agent_name, url) do
    Parser.parse_data(url)
    _crawlable(agent_name)
  end

  defp _crawlable?(user_agent) do
    !(Store.get()
      |> Map.values()
      |> Enum.any?(fn agent -> Map.get(agent, :name) == user_agent end)) &&
      !(Store.get() |> Map.get("*"))
  end

  defp _crawlable(user_agent) do
    agents = Store.get()
    user_agent = Map.get(agents, user_agent, %UserAgent{name: user_agent})

    all_agent =
      if !user_agent do
        Map.get(agents, "*", %UserAgent{})
      else
        %UserAgent{}
      end

    %UserAgent{
      name: user_agent.name,
      disallowed_urls: user_agent.disallowed_urls ++ all_agent.disallowed_urls,
      allowed_urls: user_agent.allowed_urls ++ all_agent.allowed_urls,
      delay: user_agent.delay || all_agent.delay || 0
    }
  end
end
