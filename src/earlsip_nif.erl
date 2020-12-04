-module(earlsip_nif).
%-include("earlsip.hrl").

-compile(no_native).
-on_load(init/0).

-export([
    siphash/2
]).

-define(APP, earlsip).
-define(LIB, earlsip).

% public
-spec siphash(binary(), binary()) -> binary().
siphash(_, _) ->
    not_loaded(?LINE).

% private
init() ->
    Lib = case code:priv_dir(?APP) of
        {error, bad_name} ->
            case filelib:is_dir(filename:join(["..", priv])) of
                true ->
                    filename:join(["..", priv, ?LIB]);
                _ ->
                    filename:join([priv, ?LIB])
            end;
        Dir ->
            filename:join(Dir, ?LIB)
    end,
    ok = erlang:load_nif(Lib, 0).

not_loaded(Line) ->
    erlang:nif_error({not_loaded, [{module, ?MODULE}, {line, Line}]}).
