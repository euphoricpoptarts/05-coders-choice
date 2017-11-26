defmodule VariableServer.Server do

  use Agent

  @agent VariableMap

  def handle_call( key , _from, _state) do
    { :reply,
    Agent.get(@agent, &Map.fetch(&1,key)),
    0 }
  end

  def handle_cast({ key, value }, _state) do
    Agent.update(@agent, &Map.put(&1, key, value))
    { :noreply,
     0 }
  end

  def init(args) do
    Agent.start_link(fn -> args end, name: @agent)
    { :ok, 0 }
  end
  
  
end