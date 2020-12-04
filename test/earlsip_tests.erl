-module(earlsip_tests).
-include_lib("eunit/include/eunit.hrl").

siphash_test() ->
    ?assertEqual(
       <<55,15,199,134,239,189,243,166>>,
       earlsip:siphash(<<0:128>>,<<"erlang">>)
      ).
