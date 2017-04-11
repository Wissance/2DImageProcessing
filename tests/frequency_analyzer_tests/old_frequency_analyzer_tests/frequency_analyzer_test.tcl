restart
add_force {/frequency_analyzer_testbench/sample_data} -radix hex {0 0ns} {1 500us} {0 556us} {1 611us} {0 667us} {1 722us} {0 778us} {1 833us} {0 835us} {1 860us} {0 900us} {1 942us} {0 992us} {1 1048us} {0 1088us} {1 1130us} {0 1135us} {1 1160us} {0 1185us} {1 1210us} {0 1235us} {1 1260us} {0 1350us} {1 1406us} {0 1462us} {1 1518us}
add_force {/frequency_analyzer_testbench/clock} -radix hex {1 0ns} {0 10ns} -repeat_every 20ns
add_force {/frequency_analyzer_testbench/enable} -radix hex {0 0ns} {1 400us} {0 1450us}
add_force {/frequency_analyzer_testbench/clear} -radix hex {1 0ns} {0 400us} {1 410us} {0 1540us} {1 1550us}
run 2 ms