-module(msys_check_queue).
-behavior(msys_system).

-export([init/1]).

-record(chkq, {
	runtime,
	check_id
}).


