-module(msys_action).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {init, 1}, % application startup system init
                {report, 3} %status, checkinfo, hostinfo
        ];
behaviour_info(_Other) -> undefined.
