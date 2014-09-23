-module(msys_check).

-export([behaviour_info/1]).

-export([run/3]).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {init, 1}, %called at application start to prep report action
                {check, 2}
        ];
behaviour_info(_Other) -> undefined.

run(Callback, ServiceCheckID) ->
% pull the service check up.
% Get the host info and service info from the service check, and merge options together.
	HostInfo = [],
	CheckInfo=[],
	{ok, Status} = Callback:check(HostInfo, CheckInfo),
%update the service check with the results of the check
	ok.
