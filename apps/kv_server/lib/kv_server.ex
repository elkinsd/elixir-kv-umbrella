defmodule KVServer do
  use Application

  def accept(port) do
    # options below mean:
    # 1. `:binary` - receives data as binaries instead of lists
    # 2. `packet: :line` - receives data line by line
    # 3. `active: false` - block on `:gen_tcp.recv/2` until data is available
    #
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false])
    IO.puts "Accepting connections on port #{port}"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Task.Supervisor.start_child(KVServer.TaskSupervisor, fn -> serve(client) end)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    msg =
      case read_line(socket) do
        {:ok, data} ->
          case KVServer.Command.parse(data) do
            {:ok, command} ->
              KVServer.Command.run(command)
            {:error, _} = err ->
              err
          end
        {:error, _} = err ->
          err
      end

    write_line(socket, msg)
    serve(socket)
  end

  defp read_line(socket) do
    :gen_tcp.recv(socket, 0)
  end

  defp write_line(socket,msg) do
    :gen_tcp.send(socket, format_message(msg))
  end

  defp format_message({:ok, text}), do: text
  defp format_message({:error, :unknown_command}), do: "UNKNOWN COMMAND\r\n"
  defp format_message({:error, :not_found}), do: "NOT FOUND\r\n"
  defp format_message({:error, _}), do: "ERROR\r\n"


  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: KVServer.TaskSupervisor]]),
      worker(Task, [KVServer, :accept, [4040]])
    ]

    opts = [strategy: :one_for_one, name: KVServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
