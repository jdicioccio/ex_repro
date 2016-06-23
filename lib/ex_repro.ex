defmodule ExRepro do
  use Application

  def start(_type, _args) do
   {:ok, pid} = Task.start(fn -> loop() end)
   Process.register(pid, :repro)
   {:ok, pid}
  end

  def loop() do
    receive do
      _ -> fn -> IO.puts "ping" end.()
    end
    loop
  end
end
