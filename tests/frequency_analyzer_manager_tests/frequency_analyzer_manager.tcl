#add_force {/frequency_analyzer_manager_testbench/data} -radix hex {0 0ns} {1 500us} {0 556us} {1 611us} {0 667us} {1 722us} {0 778us} {1 833us} {0 835us} {1 860us} {0 885us} {1 910us} {0 935us} {1 #960us} {0 985us} {1 1010us} {0 1035us} {1 1060us} {0 1085us} {1 1110us} {0 1135us} {1 1160us} {0 1250us} {1 1306us} {0 1362us} {1 1418us}
add_force {/frequency_analyzer_manager_testbench/pixel_clock} -radix hex {1 0ns} {0 10ns} -repeat_every 20ns
add_force {/frequency_analyzer_manager_testbench/start} -radix hex {1 0ns} {0 1us} {1 500ms} {0 500001us} -repeat_every 501ms 
add_force {/frequency_analyzer_manager_testbench/stop} -radix hex {0 0ns} {1 499ms} {0 500ms} -repeat_every 501ms 
add_force {/frequency_analyzer_manager_testbench/clear} -radix hex {1 0ns} {0 5000ms} 
