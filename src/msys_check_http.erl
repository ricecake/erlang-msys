-module(msys_check_http).
-behavior(msys_check).

-export([init/1, check/2]).

init(_Args) -> ok.

check(HostInfo, CheckInfo) ->
  {ok,{{_, Code, Status}, _, _}} = httpc:request(head, {"http://google.com", []}, [], []).
% need to hable casr where we cant even connect...
