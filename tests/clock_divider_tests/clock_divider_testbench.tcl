restart
add_force {/clock_divider_testbench/reset} -radix hex {0 0ns} {1 50ns}
add_force {/clock_divider_testbench/input_clock} -radix hex {1 0ns} {0 5000ps} -repeat_every 10000ps
run 10us