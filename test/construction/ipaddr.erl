-module(ipaddr).

-include_lib("eunit/include/eunit.hrl").

-define(FILENAME, "test/construction/" ?MODULE_STRING ".yaml").

setup() ->
    application:start(yamerl),
    yamerl_app:set_param(node_mods, [yamerl_node_ipaddr]).

simple_test_() ->
    {setup,
      fun setup/0,
      [
        ?_assertMatch(
          [
            [
              {192, 168, 1, 10},
              {{192, 168, 1, 10}, 24},
              {{192, 168, 1, 10}, {192, 168, 1, 20}},
              {8193,16848,1,28696,0,0,1,2},
              {{8193,16848,1,28696,0,0,1,0},64},
              {{8193,16848,1,28696,0,0,1,2},{8193,16848,1,28696,0,0,1,5}},
              "Not an IP address"
            ]
          ],
          yamerl_constr:file(?FILENAME, [{detailed_constr, false}])
        )
      ]
    }.

detailed_test_() ->
    {setup,
      fun setup/0,
      [
        ?_assertMatch(
          [
            {yamerl_doc,
              {yamerl_seq,yamerl_node_seq,"tag:yaml.org,2002:seq",
                [{line,1},{column,1}],
                [{yamerl_ip_addr,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,1},{column,3}],
                    {192,168,1,10}},
                  {yamerl_ip_netmask,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,2},{column,3}],
                    {192,168,1,10},
                    24},
                  {yamerl_ip_range,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,3},{column,3}],
                    {192,168,1,10},
                    {192,168,1,20}},
                  {yamerl_ip_addr,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,5},{column,3}],
                    {8193,16848,1,28696,0,0,1,2}},
                  {yamerl_ip_netmask,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,6},{column,3}],
                    {8193,16848,1,28696,0,0,1,0},
                    64},
                  {yamerl_ip_range,yamerl_node_ipaddr,
                    "tag:yamerl,2012:ipaddr",
                    [{line,7},{column,3}],
                    {8193,16848,1,28696,0,0,1,2},
                    {8193,16848,1,28696,0,0,1,5}},
                  {yamerl_str,yamerl_node_str,"tag:yaml.org,2002:str",
                    [{line,9},{column,3}],
                    "Not an IP address"}],
                7}}
          ],
          yamerl_constr:file(?FILENAME, [{detailed_constr, true}])
        )
      ]
    }.
