defmodule RoboxirTest do
  use ExUnit.Case

  alias Roboxir.UserAgent

  test "crawlable/2 returns UserAgent struct with parsed data" do
    assert %UserAgent{} = Roboxir.crawlable("*", "https://google.com/")
  end
end
