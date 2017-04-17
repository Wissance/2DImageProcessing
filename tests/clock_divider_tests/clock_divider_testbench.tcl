restart
add_force {/clock_divider_testbench/input_clock} -radix hex {1 0ns} {0 5ns} -repeat_every 10ns
run 1 us