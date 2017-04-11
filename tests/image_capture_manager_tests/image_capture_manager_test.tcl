restart
#AXI Signals
add_force {/image_capture_manager_testbench/aclk} -radix hex {1 0ns} {0 5000ps} -repeat_every 10000ps
add_force {/image_capture_manager_testbench/aresetn} -radix hex {0} {1 100us} {0 970us} 
add_force {/image_capture_manager_testbench/awaddr} -radix hex {0} {0x1 100us} {0 250us} {0x1 450us} {0 600us}
add_force {/image_capture_manager_testbench/awprot} -radix hex {0}
add_force {/image_capture_manager_testbench/awvalid} -radix hex {0} {1 100us} {0 300us} {1 450us} {0 700us}
add_force {/image_capture_manager_testbench/awready} -radix hex {0} {1 100us} {0 250us} {1 450us} {0 600us}
add_force {/image_capture_manager_testbench/wready} -radix hex {0} {1 250us} {0 450us} {1 700us} {0 800us}
add_force {/image_capture_manager_testbench/wdata} -radix hex {0} {0x00000001 250us} {0 450us} {0x00000002 600us} {0 800us}
add_force {/image_capture_manager_testbench/wstrb} -radix hex {0} {0x1 250us} {0 350us} {0x1 600us} {0 700us}
add_force {/image_capture_manager_testbench/wvalid} -radix hex {0} {1 250us} {0 450us} {1 600us} {0 800us}
add_force {/image_capture_manager_testbench/bready} -radix hex {0} {1 450us} {0 550us} {1 800us} {0 900us}

run 1ms