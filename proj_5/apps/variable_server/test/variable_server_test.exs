defmodule VariableServerTest do
  use ExUnit.Case
  doctest VariableServer

  test "set and get" do
    VariableServer.start_link
    VariableServer.setVar("x",9)
    assert VariableServer.getVar("x") == 9
  end

  test "set and get 2" do
    VariableServer.start_link
    VariableServer.setVar("x",9)
    VariableServer.setVar("y",27)
    assert VariableServer.getVar("x") == 9
  end

  test "set and get 3" do
    VariableServer.start_link
    VariableServer.setVar("x",9)
    VariableServer.setVar("x",27)
    assert VariableServer.getVar("x") == 27
  end

end
