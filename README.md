KvUmbrella
==========

Example Elixir umbrella project for Key-Value store and server

=======

## Umbrella project layout

One project -> many applications

*  kv_umbrella
   *  apps
      *   kv
      *   kv_server

=======

## Mix examples

### Create new umbrella project
```
$ mix new kv_umbrella --umbrella
* creating .gitignore
* creating README.md
* creating mix.exs
* creating apps
* creating config
* creating config/config.exs

Your umbrella project was created successfully.
Inside your project, you will find an apps/ directory
where you can create and host many apps:

    cd kv_umbrella
    cd apps
    mix new my_app

Commands like `mix compile` and `mix test` when executed
in the umbrella project root will automatically run
for each application in the apps/ directory.
```

### Create new application in umbrella project
```
$ cd kv_umbrella/apps/
$ mix new kv_server --module KVServer --sup
* creating README.md
* creating .gitignore
* creating mix.exs
* creating config
* creating config/config.exs
* creating lib
* creating lib/kv_server.ex
* creating test
* creating test/test_helper.exs
* creating test/kv_server_test.exs

Your mix project was created successfully.
You can use mix to compile it, test it, and more:

    cd kv_server
    mix test

Run `mix help` for more commands.
```

### Test all applications in umbrella project
```
$ mix test
==> kv
Compiled lib/kv.ex
Compiled lib/kv/bucket/supervisor.ex
Compiled lib/kv/bucket.ex
Compiled lib/kv/supervisor.ex
Compiled lib/kv/registry.ex
Generated kv.app
.......

Finished in 0.1 seconds (0.1s on load, 0.00s on tests)
7 tests, 0 failures

Randomized with seed 993436
==> kv_server
Compiled lib/kv_server.ex
Generated kv_server.app
.

Finished in 0.00 seconds
1 test, 0 failures

Randomized with seed 52177
```

=======

At this point the pre-distributed application is "complete".

