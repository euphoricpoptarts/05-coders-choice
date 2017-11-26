defmodule Parser.Funs do
  
  def handleSubQuery(query,"pow") do
    [ param1, param2 ] = String.split(query,",")
    x = Parser.parse(param1)
    y = Parser.parse(param2)
    { x, _ } = Float.parse(x)
    { y, _ } = Float.parse(y)
    
    :math.pow(x,y)
  end

  def handleSubQuery(query,"log") do
    [ param1, param2 ] = String.split(query,",")
    x = Parser.parse(param1)
    y = Parser.parse(param2)
    { x, _ } = Float.parse(x)
    { y, _ } = Float.parse(y)
    
    :math.log(y)/:math.log(x)
  end

  def handleSubQuery(query,"sin") do
    x = Parser.parse(query)
    { x, _ } = Float.parse(x)
    
    #couldn't find a way to do floating point modulus
    #so i decided to use built in implementations

    :math.sin(x)
  end
  
  def handleSubQuery(query,"cos") do
    x = Parser.parse(query)
    { x, _ } = Float.parse(x)
    
    :math.cos(x)
  end

  def handleSubQuery(query,"tan") do
    x = Parser.parse(query)
    { x, _ } = Float.parse(x)
    
    :math.tan(x)
  end

  def handleSubQuery(query,_fun) do
    Parser.parse(query)
  end

end
