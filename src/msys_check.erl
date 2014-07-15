-module(msys_check).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {init, 1},
                {check, 3}
        ];
behaviour_info(_Other) -> undefined.
