defmodule Proj5.Parser do
  
  def parseParen(query,0,_openParen,_parenCount,"") do
    parseParen(query,0,0,0,String.at(query,0))
  end
  
  def parseParen(query,iterator,_openParen,0,"(") do
    parseParen(query,iterator + 1,iterator,1,String.at(query,iterator + 1))
  end

  def parseParen(query,iterator,openParen,parenCount,"(") do
    parseParen(query,iterator + 1,openParen,parenCount + 1,String.at(query,iterator + 1))
  end

  def parseParen(query,iterator,openParen,1,")") do
    len = iterator-openParen-1
    input = String.slice(query,openParen+1,len)
    output = parse(input)
    iterator = openParen + String.length(output)
    input = "(#{input})"
    query = String.replace(query,input,output)
    parseParen(query,iterator,openParen,0,String.at(query,iterator))
  end

  def parseParen(query,iterator,openParen,parenCount,")") do
    parseParen(query,iterator + 1,openParen,parenCount - 1,String.at(query,iterator + 1))
  end

  def parseParen(query,_iterator,_openParen,_parenCount,nil) do
    query
  end

  def parseParen(query,iterator,openParen,parenCount,_) do
    parseParen(query,iterator + 1,openParen,parenCount,String.at(query,iterator + 1))
  end

  def parseOps(query) do
    params = Regex.split(~r{(?<splitter>[\+\-\/\*])\-?},query,on: [:splitter])
    ops = Regex.scan(~r{(?<splitter>[\+\-\/\*])\-?},query,on: [:splitter])
    { params, ops } = runMultsAndDivs(params, ops)
    runAddsAndSubs(params, ops)
  end

  def runAddsAndSubs([paramsH | paramsT], [ "+" | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    { paramsH, _ } = Float.parse("#{paramsH}")
    { param2, _ } = Float.parse("#{param2}")
    runAddsAndSubs([ paramsH + param2 | paramsT], opsT)
  end

  def runAddsAndSubs([paramsH | paramsT], [ "-" | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    { paramsH, _ } = Float.parse("#{paramsH}")
    { param2, _ } = Float.parse("#{param2}")
    runAddsAndSubs([ paramsH - param2 | paramsT], opsT)
  end

  def runAddsAndSubs([paramsH | _paramsT], []) do
    "#{paramsH}"
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , "*"] | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    { paramsH, _ } = Float.parse("#{paramsH}")
    { param2, _ } = Float.parse("#{param2}")
    { leftParams, leftOps } = runMultsAndDivs([ paramsH * param2 | paramsT], opsT)
    { leftParams, leftOps }
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , "/"] | opsT]) do
    [ param2 | paramsT ] = paramsT

    #i don't want to bother checking if this is already a Float
    #so i interpolate to a string and parse to float
    { paramsH, _ } = Float.parse("#{paramsH}")
    { param2, _ } = Float.parse("#{param2}")
    { leftParams, leftOps } = runMultsAndDivs([ paramsH / param2 | paramsT], opsT)
    { leftParams, leftOps }
  end

  def runMultsAndDivs([paramsH | paramsT], [ [_ , op] | opsT]) do
    { leftParams, leftOps } = runMultsAndDivs(paramsT, opsT)
    { [ paramsH | leftParams ] , [ op | leftOps ] }
  end

  def runMultsAndDivs([paramsH | _paramsT], [] ) do
    { [ paramsH ] , [] }
  end

  def parse(query) do
    query = parseParen(query,0,0,0,"")
    parseOps(query)
  end

end
