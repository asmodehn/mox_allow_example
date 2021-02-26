defmodule MoxAllow.Srv do
  use GenServer

  @svc_impl Application.get_env(:mox_allow, :svc_impl)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, {:ok}, opts)
  end

  def svc_call() do
    GenServer.call(__MODULE__, {:svc_call})
  end

  @impl true
  def init({:ok}) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:svc_call}, _from, _state) do
    {:reply, @svc_impl.svc_call(), %{}}
  end
end