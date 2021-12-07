defmodule Roboxir.Store do
  use GenServer, restart: :permanent

  @process __MODULE__

  alias Roboxir.UserAgent

  def start_link(initial_state) do
    GenServer.start_link(@process, initial_state, name: @process)
  end

  def add_agent(agent) do
    GenServer.cast(@process, {:add_agent, agent})
  end

  def add_delay(agent_name, delay) do
    GenServer.cast(@process, {:add_delay, agent_name, delay})
  end

  def add_disallowed_path(agent_name, path) do
    GenServer.cast(@process, {:add_disallowed_path_to_agent, agent_name, path})
  end

  def add_allowed_path(agent_name, path) do
    GenServer.cast(@process, {:add_allowed_path_to_agent, agent_name, path})
  end

  def add_sitemap_path(agent_name, path) do
    GenServer.cast(@process, {:add_sitemap_path_to_agent, agent_name, path})
  end

  def flush(), do: GenServer.cast(@process, :flush)

  def get(), do: GenServer.call(@process, :get)

  def get_agent(agent_name), do: GenServer.call(@process, {:get_agent, agent_name})

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:get, _from, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_call({:get_agent, agent_name}, _from, current_state) do
    case Map.get(current_state, agent_name) do
      %UserAgent{} = agent -> {:reply, {:ok, agent}, current_state}
      _ -> {:reply, {:error, nil}, current_state}
    end
  end

  def handle_cast({:add_agent, agent}, current_state) do
    {:noreply, Map.put_new(current_state, agent.name, agent)}
  end

  def handle_cast({:add_delay, agent_name, delay}, current_state) do
    agent = Map.get(current_state, agent_name)
    updated_agent = %{agent | delay: delay}
    {:noreply, Map.put(current_state, agent_name, updated_agent)}
  end

  def handle_cast({:add_disallowed_path_to_agent, agent_name, path}, current_state) do
    agent = Map.get(current_state, agent_name)
    updated_agent = %{agent | disallowed_urls: [path | agent.disallowed_urls]}
    {:noreply, Map.put(current_state, agent_name, updated_agent)}
  end

  def handle_cast({:add_allowed_path_to_agent, agent_name, path}, current_state) do
    agent = Map.get(current_state, agent_name)
    updated_agent = %{agent | allowed_urls: [path | agent.allowed_urls]}
    {:noreply, Map.put(current_state, agent_name, updated_agent)}
  end

  def handle_cast({:add_sitemap_path_to_agent, agent_name, path}, current_state) do
    agent = Map.get(current_state, agent_name)
    updated_agent = %{agent | sitemap_urls: [path | agent.allowed_urls]}
    {:noreply, Map.put(current_state, agent_name, updated_agent)}
  end

  def handle_cast(:flush, _current_state) do
    {:noreply, %{}}
  end
end
