defmodule Proj5.ParserTest do
  use ExUnit.Case
  doctest Proj5.Parser

  test "parseParen test1" do
    assert Proj5.Parser.parse("(1((3)4(7))2)6(11)") == "13472611"
  end

  test "parseParen test2" do
    assert Proj5.Parser.parse("4(7(3(5)(2)(9(6))))") == "4735296"
  end

  test "parseParen test3" do
    assert Proj5.Parser.parse("4*(7+(3-(5)-(2)/(9*-6)))") == "20.14814814814815"
  end
end
