defmodule StoreTest do
  use ExUnit.Case, async: true

  alias Roboxir.UserAgent

  setup do
    agent = %UserAgent{name: "test_agent"}
    Roboxir.Store.add_agent(agent)
    {:ok, %{agent: agent}}
  end

  test "add_agent/1 adds new agent to the store", %{agent: agent} do
    {:ok, agent_from_store} = Roboxir.Store.get_agent(agent.name)
    assert agent_from_store.name == agent.name
  end

  test "add_delay/2 adds delay to agent in store", %{agent: agent} do
    delay = :math.floor(:rand.uniform() * 10 + 1)
    assert agent.delay == nil
    Roboxir.Store.add_delay(agent.name, delay)
    {:ok, agent} = Roboxir.Store.get_agent(agent.name)
    assert agent.delay == delay
  end

  test "add_disallowed_path/2" do
    disallowed_path = "/search/"
    agent = %UserAgent{name: "test_agent"}
    Roboxir.Store.add_agent(agent)
  end
end
