restart
#AXI Signals
add_force {/axi_slave_impl_testbench/S_AXI_ACLK} -radix hex {1 0ns} {0 5ns} -repeat_every 10ns
add_force {/axi_slave_impl_testbench/S_AXI_ARESETN} -radix hex {0} {1 100us} {0 2000us}
add_force {/axi_slave_impl_testbench/register_operation} -radix hex {0} {0x2 150010ns} {0 150020ns} {0x2 150030ns} {0 150040ns} {0x2 150050ns} {0 150060ns} {0x2 150070ns} {0 150080ns} {0x2 150090ns} {0 150100ns} {0x2 150110ns} {0 150120ns} {0x1 800us} {0 850us} {0x1 900us} {0 950us}
add_force {/axi_slave_impl_testbench/register_number} -radix hex {0} {0x01 150010ns} {0x02 150030ns} {0x03 150050ns} {0x04 150070ns} {0x05 150090ns} {0x06 150110ns} {0x00 150120ns} {0x02 800us} {0x04 900us} {0 1000us}
add_force {/axi_slave_impl_testbench/register_write} -radix hex {0} {0x00000011 150010ns} {0 150020ns} {0x00000022 150030ns} {0 150040ns} {0x00000033 150050ns} {0 150060ns} {0x00000044 150070ns} {0 150080ns} {0x00000055 150090ns} {0 150100ns} {0x00000066 150110ns} {0 150120ns}
# read from AXI
add_force {/axi_slave_impl_testbench/S_AXI_ARADDR} -radix bin {0000000000} {0000000100 220us} {0000001000 230us} {0000001100 240us} {0000010000 250us} {0000010100 260us} {0000000000 270us}
add_force {/axi_slave_impl_testbench/S_AXI_ARVALID} -radix hex {0} {1 205us} {0 210us} {1 215us} {0 220us} {1 225us} {0 240us} {1 245us} {0 250us} {1 255us} {0 260us} {1 265us} {0 270us}
add_force {/axi_slave_impl_testbench/S_AXI_RREADY} -radix hex {0} {1 200us} {0 280us}
# write from AXI
add_force {/axi_slave_impl_testbench/S_AXI_AWADDR} -radix bin {0} {0000001100 500us} {0000000100 600us} {0000000000 700us}
add_force {/axi_slave_impl_testbench/S_AXI_AWVALID} -radix hex {0} {1 490us} {0 570us} {1 600us} {0 700us}
add_force {/axi_slave_impl_testbench/S_AXI_WVALID} -radix hex {0} {1 500us} {0 590us} {1 600us} {0 700us}
add_force {/axi_slave_impl_testbench/S_AXI_WSTRB} -radix hex {0} {0x1 490us} {0 550us} {0x1 610us} {0 650us}
add_force {/axi_slave_impl_testbench/S_AXI_WDATA} -radix hex {0} {0x000000FF 500us} {0 590us} {0x000000EE 600us} {0 700us}

run 2ms