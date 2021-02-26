defmodule MoxAllow.SvcBehaviour do
  @callback svc_call :: term()
end

defmodule MoxAllow.Svc do
  @behaviour MoxAllow.SvcBehaviour
  @impl true
  def svc_call(), do: :answer
end
