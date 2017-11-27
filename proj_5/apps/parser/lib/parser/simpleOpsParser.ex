defmodule Parser.SimpleOpsParser do

  def parseOps(query) do

    #removes the function symbols from the query
    query = Regex.replace(~r{(?:sin|cos|tan|pow|log)},query,"")

    #splits query on *,/,+,- and ignores negative signs (- is same as minus)
    #removes the operator symbol but not the minus sign
    params = Regex.split(~r{[^e](?<splitter>[\+\-\/\*])\-?},query,on: [:splitter], trim: true)
    
    #finds all occurrences of operators
    ops = Regex.scan(~r{[^e](?<splitter>[\+\-\/\*])\-?},query,on: [:splitter])

    { params, ops } = runMultsAndDivs(params, ops)
    runAddsAndSubs(params, ops)
  end

  def runAddsAndSubs([paramsH | paramsT], [ "+" | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    paramsH = getVar( Float.parse("#{paramsH}"), paramsH)
    param2 = getVar( Float.parse("#{param2}"), param2)

    runAddsAndSubs([ paramsH + param2 | paramsT], opsT)
  end

  def runAddsAndSubs([paramsH | paramsT], [ "-" | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    paramsH = getVar( Float.parse("#{paramsH}"), paramsH)
    param2 = getVar( Float.parse("#{param2}"), param2)

    runAddsAndSubs([ paramsH - param2 | paramsT], opsT)
  end

  def runAddsAndSubs([paramsH | _paramsT], []) do
    paramsH = getVar( Float.parse("#{paramsH}"), paramsH)
    "#{paramsH}"
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , "*"] | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    paramsH = getVar( Float.parse("#{paramsH}"), paramsH)
    param2 = getVar( Float.parse("#{param2}"), param2)

    { leftParams, leftOps } = runMultsAndDivs([ paramsH * param2 | paramsT], opsT)
    { leftParams, leftOps }
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , "/"] | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    paramsH = getVar( Float.parse("#{paramsH}"), paramsH)
    param2 = getVar( Float.parse("#{param2}"), param2)

    { leftParams, leftOps } = runMultsAndDivs([ paramsH / param2 | paramsT], opsT)
    { leftParams, leftOps }
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , op] | opsT]) do
    { leftParams, leftOps } = runMultsAndDivs(paramsT, opsT)
    { [ paramsH | leftParams ] , [ op | leftOps ] }
  end

  def runMultsAndDivs([paramsH | _paramsT], [] ) do
    { [ getVar( Float.parse("#{paramsH}"), paramsH) ] , [] }
  end

  def getVar({ value, _}, _) do value end

  def getVar(_, key) do 
    VariableServer.getVar(key) 
  end

end