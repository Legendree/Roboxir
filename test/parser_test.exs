defmodule ParserTest do
  use ExUnit.Case, async: true

  test "parse_data/1 returns parsed data for given url" do
    assert :ok == Roboxir.Parser.parse_data("https://google.com/")
  end
end
