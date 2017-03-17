#AXI Signals
add_force {/axi_slave_impl_testbench/S_AXI_ACLK} -radix hex {1 0ns} {0 5000ps} -repeat_every 10000ps
add_force {/axi_slave_impl_testbench/S_AXI_ARESETN} -radix hex {0} {1 100us} {0 970us} 
add_force {/axi_slave_impl_testbench/S_AXI_AWADDR} -radix hex {0} {0x1 100us} {0 250us} {0x1 450us} {0 600us}
add_force {/axi_slave_impl_testbench/S_AXI_AWPROT} -radix hex {0}
add_force {/axi_slave_impl_testbench/S_AXI_AWVALID} -radix hex {0} {1 100us} {0 300us} {1 450us} {0 700us}
add_force {/axi_slave_impl_testbench/S_AXI_WREADY} -radix hex {0} {1 100us} {0 250us} {1 450us} {0 600us}
add_force {/axi_slave_impl_testbench/S_AXI_BRESP} -radix hex {0} {1 250us} {0 450us} {1 700us} {0 800us}
add_force {/axi_slave_impl_testbench/S_AXI_WDATA} -radix hex {0} {0x00000001 250us} {0 450us} {0x00000002 600us} {0 800us}
add_force {/axi_slave_impl_testbench/S_AXI_WSTRB} -radix hex {0} {0x1 250us} {0 350us} {0x1 600us} {0 700us}
add_force {/axi_slave_impl_testbench/S_AXI_WVALID} -radix hex {0} {1 250us} {0 450us} {1 600us} {0 800us}
add_force {/axi_slave_impl_testbench/S_AXI_BREADY} -radix hex {0} {1 450us} {0 550us} {1 800us} {0 900us}


