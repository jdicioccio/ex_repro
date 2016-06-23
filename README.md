# ExRepro

Steps to reproduce:

```
iex -S mix
iex(1)> Kernel.send :repro, :hi
ping
:hi
```

That works.. Now...

```
iex(2)> :int.i ExRepro
{:module, ExRepro}
iex(3)> Kernel.send :repro, :hi        
:hi
iex(4)> 
18:14:23.774 [error] Task #PID<0.84.0> started from #PID<0.83.0> terminating
** (UndefinedFunctionError) function anonymous fn/0 in ExRepro.loop/0 is undefined or private
    (ex_repro) anonymous fn() in ExRepro.loop/0
    (ex_repro) lib/ex_repro.ex:12: ExRepro.loop/0
    (elixir) lib/task/supervised.ex:94: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Function: #Function<1.21253709/0 in ExRepro.start/2>
    Args: []
```

Basically, once the interpreter mode is activated for the module, anonymous
functions cease to work. That is, until the module is reloaded. So, if the end
of `loop/0` were changed to be `ExRepro.loop`, it would start working once again.
