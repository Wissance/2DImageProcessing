restart
add_force {/frequency_analyzer_synch_testbench/clock} -radix hex {1 0ns} {0 5ns} -repeat_every 10ns
add_force {/frequency_analyzer_synch_testbench/enable} -radix hex {0 0ns} {1 400us} {0 5ms} {1 5100us} {0 7ms}
add_force {/frequency_analyzer_synch_testbench/reset} -radix hex {0 0ns} {1 50us} {0 5ms} {1 5050us}
run 6ms
