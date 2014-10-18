-module(msys_check_queue).
-behavior(msys_system).
-behaviour(gen_server).

-define(SERVER, ?MODULE).

-record(chkq, {
	runtime,
	check_id
}).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, setup/1, scheduleCheck/2, checkQueue/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

setup(_opts) -> ok.

checkQueue() -> {ok, []}.

scheduleCheck(Interval, CheckID) -> gen_server:call(?SERVER, {queue, {Interval, CheckID}})..

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init(Args) ->
    {ok, Args}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

popQueue() -> {ok, []}.

scheduleNextRun() -> ok.

timestamp() -> {Mega, Secs, _Micro} = erlang:now(),  Mega*1000*1000 +Secs.

nextRun(Interval) -> timestamp()+Interval.

