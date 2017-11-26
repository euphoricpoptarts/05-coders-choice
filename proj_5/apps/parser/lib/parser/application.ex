defmodule Parser.Application do
  use Application

  def start(_type, _args) do
    Parser.Supervisor.start_link(name: Parser.Supervisor)
  end

end