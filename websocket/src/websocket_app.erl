%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(websocket_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/websocket", autobahn_echo, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 9009}],
		[{env, [{dispatch, Dispatch}]}]),
	websocket_sup:start_link().

stop(_State) ->
	ok.
