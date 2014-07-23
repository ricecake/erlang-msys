-module(msys_check_http).
-behavior(msys_check).

-export([init/1, check/2]).

init(_Args) -> ok.

check(HostInfo, CheckInfo) ->
  case httpc:request(head, {"http://google.com", []}, [], []) of
    {ok,{{_, Code, Status}, _, _}} -> {ok, {up, [Code, Status]}}
  end.
% need to hable casr where we cant even connect...
