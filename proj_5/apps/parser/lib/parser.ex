defmodule Parser do

  def parseAssign(query) do
    list = String.split(query,"<-", trim: true);
    handleAssign(list)
  end

  def handleAssign([ param1 ]) do { String.trim(param1), nil} end

  def handleAssign([ param1, param2 ]) do
    { String.trim(param2), String.trim(param1) }
  end

  def assignToKey(nil, result) do result end

  def assignToKey(key, result) do
    VariableServer.setVar(key, result)
    result
  end

  def parse(query) do
    { query, key } = parseAssign(query)
    query = Parser.NestedParser.parseParen(query,0,0,0,"")
    result = Parser.SimpleOpsParser.parseOps(query)
    assignToKey(key,result)
  end

end
