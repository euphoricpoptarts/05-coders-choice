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
    output = parseParen(input,0,0,0,"")
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

  def parse(query) do
    parseParen(query,0,0,0,"")
  end

end
