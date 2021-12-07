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

  test "add_disallowed_path/2 adds disallowed url to the agent", %{agent: agent} do
    disallowed_path = "/some/disallowed-url"
    assert agent.disallowed_urls == []
    Roboxir.Store.add_disallowed_path(agent.name, disallowed_path)
    {:ok, agent} = Roboxir.Store.get_agent(agent.name)
    assert agent.disallowed_urls == [disallowed_path]
  end

  test "add_allowed_path/2 adds allowd url to the agent", %{agent: agent} do
    allowed_path = "/cool-allowed/path"
    assert agent.allowed_urls == []
    Roboxir.Store.add_allowed_path(agent.name, allowed_path)
    {:ok, agent} = Roboxir.Store.get_agent(agent.name)
    assert agent.allowed_urls == [allowed_path]
  end

  test "add_sitemap_path/2 adds allowd url to the agent", %{agent: agent} do
    sitemap_path = "/some-sitemap-path/"
    assert agent.sitemap_urls == []
    Roboxir.Store.add_sitemap_path(agent.name, sitemap_path)
    {:ok, agent} = Roboxir.Store.get_agent(agent.name)
    assert agent.sitemap_urls == [sitemap_path]
  end
end
