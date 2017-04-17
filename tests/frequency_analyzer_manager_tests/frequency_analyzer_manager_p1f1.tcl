restart
add_force {/frequency_analyzer_manager_testbench/data} -radix hex {0 0ns} {0xf0 10us} -repeat_every 20us
#{0xf0 21.18us} {0x40 21.48us} {0xf0 41.66us} {0x40 41.96us} {0xf0 62.14us} {0x40 62.44us} {0xf0 82.62us} {0x40 82.92us} {0xf0 103.1us} {0x40 103.4us} {0xf0 225.98us} {0x00 226.28us}
#{0 0ns} {0xff 0.7us} {0x00 1us} {0xff 10.38us} {0x00 10.42us} {0xff 20.50us} {0x00 21.0us} {0xff 21.1us} {0x00 21.5us} {0xff 41.1us} {0x00 41.8us} {0xff 61.6us} {0x00 62.4us} {0xff 123us}
add_force {/frequency_analyzer_manager_testbench/pixel_clock} -radix hex {1 0ns} {0 10ns} -repeat_every 20ns
add_force {/frequency_analyzer_manager_testbench/start} -radix hex {0 100ns} {1 150ns} {0 1us} {1 500ms} {0 500001us} -repeat_every 501ms 
add_force {/frequency_analyzer_manager_testbench/stop} -radix hex {0 0ns} {1 499ms} {0 500ms} -repeat_every 501ms 
add_force {/frequency_analyzer_manager_testbench/clear} -radix hex {1} {0 100ns} {1 5000ms} 
add_force {/frequency_analyzer_manager_testbench/s00_axi_aresetn} -radix hex {0} {1 100ns} {0 5000ms} 
add_force {/frequency_analyzer_manager_testbench/s00_axi_aclk} -radix hex {1 0ns} {0 5ns} -repeat_every 10ns
run 1000 ms