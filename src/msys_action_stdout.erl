-module(msys_action_stdout).

-behavior(msys_action).

-export([init/1, report/3]).

init(Args) -> ok.

report(Host, Check, Result) -> io:format("~p~n", {Host, Check, Result}).
