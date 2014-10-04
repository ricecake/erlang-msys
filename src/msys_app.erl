-module(msys_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	% Ensure That We start the supervisor before initing the tools,
	% So that it will be available to the various pieces.
	{ok, Pid} = msys_sup:start_link(),
	[ ok = msys_check:init(Check, options(Check)) || Check <- checks() ],
	[ ok = msys_action:init(Action, options(Action)) || Action <- actions() ],
	[ ok = System:init(options(System)) || System <- systems() ],
	{ok, Pid}.

stop(_State) ->
    ok.


systems() -> [
	msys_host,
	msys_node,
	msys_service,
	msys_service_check,
	msys_check_queue
].

actions() -> [
	msys_action_ws
].

checks() -> [
	msys_check_port
].

options(_)->[].
