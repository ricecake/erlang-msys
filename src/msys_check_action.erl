-module(msys_check_action).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {init, 1}, % aplicatiln startup system init
                {report, 3}
        ];
behaviour_info(_Other) -> undefined.
