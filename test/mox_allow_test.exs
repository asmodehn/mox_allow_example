defmodule MoxAllowTest do
  use ExUnit.Case, async: true
  import Hammox

  alias MoxAllow.Svc
  alias MoxAllow.SvcMock

  #  setup :verify_on_exit!

  setup do
    gensrv_pid = start_supervised!({MoxAllow.Srv, name: __MODULE__})
    %{gensrv_pid: gensrv_pid}
  end

  test "actual call" do
    # making sure behaviour is implemented as specified
    svc_call_0 = Hammox.protect({Svc, :svc_call, 0}, MoxAllow.SvcBehaviour)
    assert svc_call_0.() == :answer
  end

  test "mock call" do
    SvcMock
    |> expect(:svc_call, fn -> :mock_answer end)

    assert SvcMock.svc_call() == :mock_answer
  end

  test "indirect actual call", %{gensrv_pid: _gensrv_pid} do
    # we are using the default (application's) GenSrv here (will not work with --no-start)
    assert MoxAllow.Srv.svc_call() == :answer
  end

  test "indirect mock call", %{gensrv_pid: gensrv_pid} do
    SvcMock
    |> expect(:svc_call, fn -> :mock_answer end)
    |> allow(self(), gensrv_pid)

    # we are using the dynamically mocked GenSrv here
    assert MoxAllow.Srv.svc_call(gensrv_pid) == :mock_answer
  end
end
