defmodule StoreTest do
  use ExUnit.Case, async: true

  alias Roboxir.UserAgent

  test "add_agent/1 adds new agent to the store" do
    agent = %UserAgent{name: "test_agent"}
    Roboxir.Store.add_agent(agent)
    agents = Roboxir.Store.get()
    agent_from_store = Map.get(agents, agent.name)

    assert agent_from_store.name == agent.name
  end

  test "add_delay/1 adds delay to agent in store" do
    delay = :math.floor(:rand.uniform() * 10 + 1)
    agent = %UserAgent{name: "test_agent"}
    Roboxir.Store.add_agent(agent)
    agents = Roboxir.Store.get()
    agent_from_store = Map.get(agents, agent.name)
    assert agent_from_store.delay == nil
    Roboxir.Store.add_delay(agent_from_store.name, delay)
    agents = Roboxir.Store.get()
    agent_from_store = Map.get(agents, agent.name)

    assert agent_from_store.delay == delay
  end
end
