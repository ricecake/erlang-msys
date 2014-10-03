-module(msys_check_port).
-behavior(msys_check).

-export([init/1, check/2, ping/2]).

init(_Args) -> ok.

check(HostInfo, CheckInfo) ->
	Host = proplists:get_value(hostname, HostInfo),
	Port = proplists:get_value(port, CheckInfo),
	{NewHost, NewPort} = normalizeArgs(Host, Port),
	case ping(NewHost, NewPort) of
		{ok, {NewPort, open}}   -> {ok, {up, []}};
		{ok, {NewPort, closed}} -> {ok, {down, []}};
		Error                   -> {ok, {down, [{error, Error}]}}
	end.


normalizeArgs(Host, Port) when is_binary(Host) -> normalizeArgs(binary_to_list(Host), Port);
normalizeArgs(Host, Port) when is_binary(Port) -> normalizeArgs(Host, binary_to_integer(Port));
normalizeArgs(Host, Port) when   is_list(Port) -> normalizeArgs(Host, list_to_integer(Port));
normalizeArgs(Host, Port) when is_list(Host), is_integer(Port) -> {Host, Port}.

ping(Host, Port) when is_list(Host), is_integer(Port) ->
 case (gen_tcp:connect(Host, Port, [binary, {packet, 0}], 1000)) of
   {ok, Socket} -> {gen_tcp:close(Socket), {Port, open}};
   {error, _Reason} -> {ok, {Port, closed}};
   Error -> {error, Error}
 end.
