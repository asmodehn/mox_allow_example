defmodule MoxAllow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starting Binance Client GenServer
      {MoxAllow.Srv, name: MoxAllow.Srv},
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MoxAllow.Supervisor)
  end
end
