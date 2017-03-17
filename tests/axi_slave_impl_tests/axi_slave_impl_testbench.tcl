#AXI Signals
add_force {/axi_slave_impl_testbench/S_AXI_ACLK} -radix hex {1 0ns} {0 5ns} -repeat_every 10ns
add_force {/axi_slave_impl_testbench/S_AXI_ARESETN} -radix hex {0} {1 100us} {0 2000us}
add_force {/axi_slave_impl_testbench/register_operation} -radix hex {0} {0x2 150010ns} {0 150020ns} {0x2 150030ns} {0 150040ns} {0x2 150050ns} {0 150060ns} {0x2 150070ns} {0 150080ns} {0x2 150090ns} {0 150100ns} {0x2 150110ns} {0 150120ns}
add_force {/axi_slave_impl_testbench/register_number} -radix hex {0} {0x01 150010ns} {0x02 150030ns} {0x03 150050ns} {0x04 150070ns} {0x05 150090ns} {0x06 150110ns} {0x00 150120ns}
add_force {/axi_slave_impl_testbench/register_write} -radix hex {0} {0x00000011 150010ns} {0 150020ns} {0x00000022 150030ns} {0 150040ns} {0x00000033 150050ns} {0 150060ns} {0x00000044 150070ns} {0 150080ns} {0x00000055 150090ns} {0 150100ns} {0x00000066 150110ns} {0 150120ns}
add_force {/axi_slave_impl_testbench/S_AXI_ARADDR} -radix bin {0} {0000000100 210us} {0000001000 220us} {0000001100 230us} {0000010000 240us} {0000010100 250us} {0000011000 260us} {0000000000 270us}
add_force {/axi_slave_impl_testbench/S_AXI_ARVALID} -radix hex {0} {1 205us} {0 210us} {1 215us} {0 220us} {1 225us} {0 240us} {1 245us} {0 250us} {1 255us} {0 260us} {1 265us} {0 270us}
add_force {/axi_slave_impl_testbench/S_AXI_RREADY} -radix hex {0} {1 200us} {0 280us}



#add_force {/axi_slave_impl_testbench/S_AXI_AWADDR} -radix hex {0} {0x1 100us} {0 250us} {0x1 450us} {0 600us}
#add_force {/axi_slave_impl_testbench/S_AXI_AWPROT} -radix hex {0}
#add_force {/axi_slave_impl_testbench/S_AXI_AWVALID} -radix hex {0} {1 100us} {0 300us} {1 450us} {0 700us}
#add_force {/axi_slave_impl_testbench/S_AXI_WREADY} -radix hex {0} {1 100us} {0 250us} {1 450us} {0 600us}
#add_force {/axi_slave_impl_testbench/S_AXI_BRESP} -radix hex {0} {1 250us} {0 450us} {1 700us} {0 800us}
#add_force {/axi_slave_impl_testbench/S_AXI_WDATA} -radix hex {0} {0x00000001 250us} {0 450us} {0x00000002 600us} {0 800us}
#add_force {/axi_slave_impl_testbench/S_AXI_WSTRB} -radix hex {0} {0x1 250us} {0 350us} {0x1 600us} {0 700us}
#add_force {/axi_slave_impl_testbench/S_AXI_WVALID} -radix hex {0} {1 250us} {0 450us} {1 600us} {0 800us}
#add_force {/axi_slave_impl_testbench/S_AXI_BREADY} -radix hex {0} {1 450us} {0 550us} {1 800us} {0 900us}


