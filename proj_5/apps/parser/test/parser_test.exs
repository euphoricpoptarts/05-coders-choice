defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "parse test1" do
    { ans, _ } = Float.parse(Parser.parse("4*sin(7+(3-(5)-(2)/(9 *-6)))"))
    assert ans - -3.7910521853022568
    |> Kernel.abs < 0.000001
  end

  test "parse test2" do
    assert Parser.parse("pow(2,2*2)") == "16.0"
  end

  test "parse test3" do
    { ans, _ } = Float.parse(Parser.parse("8*sin(2*-4)"))
    assert ans - -7.914865972987054222464
    |> Kernel.abs < 0.000001
  end

  test "parse test4" do
    assert Parser.parse("log(2,8*4)") == "5.0"
  end

  test "parse test5" do
    Parser.parse("x <- 7*4")
    assert VariableServer.getVar("x") == 28
  end

  test "parse test6" do
    Parser.parse("x <- log(2,8*4)")
    assert Parser.parse("7*x") == "35.0"
  end

  test "parse test7" do
    Parser.parse("x <- 42.1")
    Parser.parse("y <- x/22")
    { ans, _ } = Float.parse(Parser.parse("sin(x*y)"))
    assert ans - -0.898929
    |> Kernel.abs < 0.00001
  end

  test "parse test8" do
    { ans, _ } = Float.parse(Parser.parse("sin(3.14159)"))
    assert ans
    |> Kernel.abs < 0.00001
  end

  test "sin pi/2" do
    assert Parser.Funs.handleSubQuery("1.57079632679","sin") - 1 
    |> Kernel.abs < 0.000005
  end

  test "cos pi/2" do
    assert Parser.Funs.handleSubQuery("1.57079632679","cos")
    |> Kernel.abs < 0.00005
  end

  test "tan pi/4" do
    assert Parser.Funs.handleSubQuery("0.78539816339","tan") - 1
    |> Kernel.abs < 0.001
  end

end
