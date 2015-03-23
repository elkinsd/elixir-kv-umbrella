KVServer
========

TCP Server example implementing the following commands:

*  CREATE
*  PUT
*  GET
*  DELETE

=======

## Erlang :gen_tcp

*  listens to a port until available and gets socket
*  waits for a client connection on that port and accepts it
*  reads the client request and writes a response back

=======

## Starting TCP socket connection acceptions
```
$ iex -S mix
Erlang/OTP 17 [erts-6.3] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Compiled lib/kv_server.ex
Generated kv_server.app
Interactive Elixir (1.1.0-dev) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> KVServer.accept(4040)
Accepting connections on port 4040
```

=======

## Don't die on halts
```
$ mix run --no-halt
```

Otherwise during Task dev each client disconnect will crash entire application


