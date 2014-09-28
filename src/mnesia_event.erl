-module(mnesia_event).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/1, start_link/2, start_link/3]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% Behaviour Definition
%% ------------------------------------------------------------------

behaviour_info(callbacks) -> 
        [
                {create, 2}, % create(NewRecord, State)
                {update, 3}, % update(NewRecord, OldRecords, State)
                {delete, 3}, % delete(Pattern,   OldRecords, State)
                {info, 3}    % info(Type, Item, State)
	];
behaviour_info(_Other) -> undefined.

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link(Module) -> start_link(Module, [Module]).
start_link(Module, Tables) -> start_link(Module, Tables, []).
start_link(Module, Tables, Options) ->
    gen_server:start_link({local, Module}, ?MODULE, {Module, Tables}, Options).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init({Mod, Tables}) ->
        [{ok, _} = mnesia:subscribe({table, Table, detailed}) || Table <- Tables],
        {ok, _} = mnesia:subscribe(system),
        {ok, State} = apply(Mod, init, [Tables]),
        {ok, {Mod, Tables, State}}.

handle_call(_Request, _From, State) -> {reply, ok, State}.
handle_cast(_Msg, State) -> {noreply, State}.

handle_info({mnesia_table_event, {write, Table, Record, [], _ActivityInfo}}, {Mod, Tables, CBState})->
	{ok, State} = apply(Mod, create, [Record, CBState]),
	{noreply, {Mod, Tables, State}};
handle_info({mnesia_table_event, {write, Table, NewRecord, OldRecords, _ActivityInfo}}, {Mod, Tables, CBState})->
	{ok, State} = apply(Mod, update, [NewRecord, OldRecords, CBState]),
	{noreply, {Mod, Tables, State}};
handle_info({mnesia_table_event, {delete, Table, Pattern, OldRecords, _ActivityInfo}}, {Mod, Tables, CBState})->
	{ok, State} = apply(Mod, delete, [Pattern, OldRecords, CBState]),
	{noreply, {Mod, Tables, State}};
handle_info({mnesia_system_event, Event}, {Mod, Tables, CBState}) ->
	{ok, State} = case Event of
		{mnesia_up, Node} ->
			apply(Mod, info, [node_up, Node, CBState]);
		{mnesia_down, Node} ->
			apply(Mod, info, [node_down, Node, CBState]);
		{mnesia_overload, Details} ->
			apply(Mod, info, [overload, Details, CBState]);
		{inconsistent_database, Context, Node} ->
			apply(Mod, info, [conflict, {Context, Node}, CBState]);
		{mnesia_fatal, Format, Args, BinaryCore} ->
			apply(Mod, info, [fatal, {Format, Args, BinaryCore}, CBState]);
		{mnesia_user, Event} ->
			apply(Mod, info, [user, Event, CBState]);
		_ -> CBState
	end,
	{noreply, {Mod, Tables, State}};
handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------
