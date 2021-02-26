defmodule MoxAllow.SvcBehaviour do
  @callback svc_call :: term()
end

defmodule MoxAllow.Svc do
  def svc_call(), do: :answer
end