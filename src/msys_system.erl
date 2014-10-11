-module(msys_system).

-export([init/2])

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) ->
        [
                {setup, 1}, % application startup system init
		{tables, 0}
        ];
behaviour_info(_Other) -> undefined.

setup(System, Options) -> System:setup(Options).
