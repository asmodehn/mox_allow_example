ExUnit.start()

Hammox.defmock(MoxAllow.SvcMock, for: MoxAllow.SvcBehaviour)

Application.put_env(:mox_allow, :svc_impl, MoxAllow.SvcMock)
