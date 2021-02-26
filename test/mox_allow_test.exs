

defmodule MoxAllowTest do
  use ExUnit.Case, async: true
  import Hammox

  alias MoxAllow.Svc
  alias MoxAllow.SvcMock

  setup :verify_on_exit!

  setup do
    gensrv_pid = start_supervised!({MoxAllow.Srv, name: __MODULE__})
    %{gensrv_pid: gensrv_pid}
  end

  test "actual call" do
    assert Svc.svc_call() == :answer
  end

  test "mock call" do
    SvcMock
    |> expect(:svc_call, fn -> :mock_answer end)

    assert SvcMock.svc_call() == :mock_answer
  end

  test "Check Mox Allowance", %{gensrv_pid: gensrv_pid} do
    SvcMock
    |> expect(:svc_call, fn -> :mock_answer end)
    |> allow(self(), gensrv_pid)

    assert MoxAllow.Srv.svc_call() == :mock_answer

  end

end