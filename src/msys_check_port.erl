-module(msys_check_port).
-behavior(msys_check).

-export([init/1, check/2, ping/2]).

init(_Args) -> ok.

check(HostInfo, CheckInfo) -> {ok, {up, []}}.


ping(Host, Port) ->
 case (gen_tcp:connect(Host, Port, [binary, {packet, 0}], 1000)) of
   {ok, Socket} -> {gen_tcp:close(Socket), {Port, open}};
   {error, _Reason} -> {ok, {Port, closed}};
   Error -> {error, Error}
 end.
