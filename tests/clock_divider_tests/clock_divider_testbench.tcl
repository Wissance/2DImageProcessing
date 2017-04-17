restart
add_force {/clock_divider_testbench/input_clock} -radix hex {1 0ns} {0 5 ns} -repeat_every 10 ns
run 1us