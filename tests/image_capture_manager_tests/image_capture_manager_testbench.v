`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module image_capture_manager_testbench #

(		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4

)
(
    	input wire aclk,
		input wire aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] awaddr,
		input wire [2 : 0] awprot,
		input wire awvalid,
		input wire awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] wstrb,
		input wire wvalid,
		input wire wready,
		output wire [1 : 0] bresp,
		output wire bvalid,
		input wire bready,

		output wire enable,
		output wire clear_memory 
);
    
image_capture_manager test(.s00_axi_aclk(aclk), .s00_axi_aresetn(aresetn), .s00_axi_awaddr(awaddr),
                           .s00_axi_awprot(awprot), .s00_axi_awvalid(awvalid), .s00_axi_awready(awready),
                           .s00_axi_wdata(wdata), .s00_axi_wstrb(wstrb), .s00_axi_wvalid(wvalid), .s00_axi_wready(wready),
                           .s00_axi_bresp(bresp), .s00_axi_bvalid(bvalid), .s00_axi_bready(bready), 
                           .image_capture_enabled(enable), .clear_memory(clear_memory));
endmodule