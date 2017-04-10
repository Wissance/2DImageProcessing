
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 131072 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list image_processing_2d_design_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[0]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[1]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[2]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[3]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[4]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[5]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[6]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[7]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[8]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[9]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[10]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[11]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[12]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[13]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[14]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[15]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[16]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[17]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[18]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[19]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[20]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[21]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[22]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[23]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[24]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[25]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[26]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[27]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[28]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[29]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[30]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency1_counter_reg[31]}]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 131072 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list LINESCANNER0_PIXEL_CLOCK_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 8 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {image_processing_2d_design_i/LINESCANNER0_DATA_1[0]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[1]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[2]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[3]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[4]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[5]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[6]} {image_processing_2d_design_i/LINESCANNER0_DATA_1[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[0]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[1]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[2]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[3]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[4]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[5]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[6]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[7]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[8]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[9]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[10]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[11]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[12]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[13]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[14]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[15]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[16]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[17]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[18]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[19]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[20]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[21]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[22]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[23]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[24]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[25]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[26]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[27]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[28]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[29]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[30]} {image_processing_2d_design_i/frequency_analyzer_manager_0/inst/frequency0_counter_reg[31]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets LINESCANNER0_PIXEL_CLOCK_IBUF_BUFG]