defmodule MathFunctionsTest do
  use ExUnit.Case
  doctest MathFunctions

  test "sin pi/2" do
    assert MathFunctions.handleSubQuery("1.57079632679","sin") - 1 
    |> Kernel.abs < 0.000005
  end

  test "cos pi/2" do
    assert MathFunctions.handleSubQuery("1.57079632679","cos")
    |> Kernel.abs < 0.00005
  end

  test "tan pi/4" do
    assert MathFunctions.handleSubQuery("0.78539816339","tan") - 1
    |> Kernel.abs < 0.001
  end
end
