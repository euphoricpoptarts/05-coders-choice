defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "parse test1" do
    assert Parser.parse("(1((3)4(7))2)6(11)") == "13472611"
  end

  test "parse test2" do
    assert Parser.parse("4(7(3(5)(2)(9(6))))") == "4735296"
  end

  test "parse test3" do
    { ans, _ } = Float.parse(Parser.parse("4*sin(7+(3-(5)-(2)/(9 *-6)))"))
    assert ans - -3.7910521853022568
    |> Kernel.abs < 0.000001
  end

  test "parse test4" do
    assert Parser.parse("pow(2,2*2)") == "16.0"
  end

  test "parse test5" do
    { ans, _ } = Float.parse(Parser.parse("8*sin(2*-4)"))
    assert ans - -7.914865972987054222464
    |> Kernel.abs < 0.000001
  end

  test "parse test6" do
    assert Parser.parse("log(2,8*4)") == "5.0"
  end

end
