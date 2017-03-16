add_force {/frequency_analyzer_testbench/sample_data} -radix hex {0 0ns} {1 500us} {0 556us} {1 611us} {0 667us} {1 722us} {0 778us} {1 833us} {0 835us} {1 860us} {0 885us} {1 910us} {0 935us} {1 960us} {0 985us} {1 1010us} {0 1035us} {1 1060us} {0 1085us} {1 1110us} {0 1135us} {1 1160us} {0 1250us} {1 1306us} {0 1362us} {1 1418us}
add_force {/frequency_analyzer_testbench/clock} -radix hex {1 0ns} {0 10ns} -repeat_every 20ns
add_force {/frequency_analyzer_testbench/enable} -radix hex {0 0ns} {1 400us} {0 1450us}
add_force {/frequency_analyzer_testbench/clear} -radix hex {0 0ns} {1 400us} {0 410us} {1 1540us} {0 1550us}

