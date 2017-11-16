defmodule MathFunctionsTest do
  use ExUnit.Case
  doctest MathFunctions

  test "sin pi/2" do
    assert MathFunctions.sin(1.57079632679) - 1 
    |> Kernel.abs < 0.000005
  end

  test "cos pi/2" do
    assert MathFunctions.cos(1.57079632679)
    |> Kernel.abs < 0.00005
  end

  test "tan pi/4" do
    assert MathFunctions.tan(0.78539816339) - 1
    |> Kernel.abs < 0.001
  end
end
