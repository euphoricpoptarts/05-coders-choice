defmodule Proj5.ParserTest do
  use ExUnit.Case
  doctest Proj5.Parser

  test "parseParen test1" do
    assert Proj5.Parser.parse("(1((3)4(7))2)6(11)") == "13472611"
  end
end
