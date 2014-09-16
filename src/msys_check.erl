-module(msys_check).

-export([behaviour_info/1]).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {init, 1}, %called at application start to prep report action
                {check, 2}
        ];
behaviour_info(_Other) -> undefined.
