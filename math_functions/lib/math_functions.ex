defmodule Proj5.MathFunctions do
  
  def sin(x) do
    x - (x*x*x/6)
    |> Kernel.+(x*x*x*x*x/120)
    |> Kernel.-(x*x*x*x*x*x*x/5040)
    |> Kernel.+(x*x*x*x*x*x*x*x*x/362880)
  end
  
  def cos(x) do
    1 - (x*x/2)
    |> Kernel.+(x*x*x*x/24)
    |> Kernel.-(x*x*x*x*x*x/720)
    |> Kernel.+(x*x*x*x*x*x*x*x/40320)
  end

  def tan(x) do
    x + (x*x*x/3)
    |> Kernel.+(2*x*x*x*x*x/15)
    |> Kernel.+(17*x*x*x*x*x*x*x/315)
    |> Kernel.+(62*x*x*x*x*x*x*x*x*x/2835)
  end

end
