-module(msys_action_ws).

-export([init/1, report/3]).

init(_Opts) ->
    Dispatch = cowboy_router:compile([
	    {'_', [
			{"/js/[...]", cowboy_static, {priv_dir, msys, "js/"}},
			{"/css/[...]", cowboy_static, {priv_dir, msys, "css/"}}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 25, [{ip, {127,0,0,1}}, {port, 8080}],
        				[{env, [{dispatch, Dispatch}]}]),
	ok.

report(_Status, _Checkinfo, _Hostinfo) -> ok.
