-module(msys_check_queue).
-behavior(msys_system).

-export([setup/1]).

-record(chkq, {
	runtime,
	check_id
}).

checkQueue() -> {ok, []}.

scheduleNextRun() -> ok.

scheduleCheck(Interval, CheckID) -> ok.
