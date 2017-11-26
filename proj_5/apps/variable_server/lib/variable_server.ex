defmodule VariableServer do
  use GenServer

  @server VariableServer

  def getVar(key) do
    { _, value } = GenServer.call(@server, key)
    { value, _ } = Float.parse("#{value}")
    value
  end

  def setVar(key,value) do
    GenServer.cast(@server, { key, value })
  end
  
  def start_link(_) do
    GenServer.start(VariableServer.Server, %{}, name: @server)
  end

end
