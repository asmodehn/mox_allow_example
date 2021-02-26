# MoxAllow

An example application for genserver mocking, because I had issues coming up with a practical design for mocks in a multiprocess setup

Design choices:

- configure the actual module via config.exs (using Application.env),
- override with a mock module in `test/test_helper.exs`,
- setup mock at runtime in the genserver code, in `init/1`, so it is effective **dynamically on startup**,
- require the pid of the GenSrv in the GenSrv module interface, to know which GenSrv process we need to talk to,
- use `start_supervised!` in tests to start a genserver for tests.
  Note that it should not matter at this point if the app genserver is running or not while doing tests.


When there are multiple GenSrv running, the pid allows one to choose which one to call.
Mock are able to be set dynamically, just by starting a GenSrv, so tests can be made in various configurations.
Potentially, this could also be working on already running apps, think "test in production !".


