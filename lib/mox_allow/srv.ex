defmodule MoxAllow.Srv do
  use GenServer

  def start_link(opts) when is_list(opts) do
    GenServer.start_link(__MODULE__, {:ok}, opts)
  end

  @doc """
  indirectly call svc. if no pid passed, assumed it is the one start by the application, which the name being __MODULE__
  """
  def svc_call(pid \\ __MODULE__) do
    # we need to pass the pid for tests to use the test genserver.
    GenServer.call(pid, {:svc_call})
  end

  @impl true
  def init({:ok}) do
    # we keep the backend implementation in state (setup on start)
    svc_impl = Application.get_env(:mox_allow, :svc_impl)

    # to use a mock or not, depending on *runtime* configuration
    {:ok, %{impl: svc_impl}}
  end

  @impl true
  def handle_call({:svc_call}, _from, %{impl: svc_impl} = state) do
    {:reply, svc_impl.svc_call(), state}
  end
end
