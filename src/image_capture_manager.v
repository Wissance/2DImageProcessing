//`include ".\src\image_capture_manager_S00_AXI.v"
`timescale 1 ns / 1 ps

	module image_capture_manager #
	(
		// Users to add parameters here
        parameter integer START_IMAGE_CAPTURE_COMMAND = 1,
        parameter integer STOP_IMAGE_CAPTURE_COMMAND = 2,  
		// User parameters ends
			 
		// Do not modify the parameters beyond this line

		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here
        output reg image_capture_enabled = 0,
        output reg clear_memory = 0,
		// User ports ends
		
		// Do not modify the ports beyond this line

		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
	
/*	wire [C_S00_AXI_DATA_WIDTH - 1 : 0] register_read_net;
	wire [C_S00_AXI_DATA_WIDTH - 1 : 0] register_write_net;
	wire [1:0] register_operation_net;
	wire [7:0] register_number_net;*/
	
    wire [C_S00_AXI_DATA_WIDTH - 1 : 0] register_read;
    reg [C_S00_AXI_DATA_WIDTH - 1 : 0] register_write;
    reg [1:0] register_operation;
    reg [7:0] register_number;
    
    always @(*)
    begin
        register_write = 0;
        //register_write_net;
        register_operation = 0;//register_operation_net;
        register_number = 0;//register_number_net;
    end
	
	
    // Instantiation of Axi Bus Interface S00_AXI
	axi_slave_impl # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.NUMBER_OF_REGISTERS(4)
	) image_capture_manager_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.register_read(register_read),
		.register_write(register_write),
		.register_number(register_number),
		.register_operation(register_operation)
	);

	// Add user logic here
    always @(posedge s00_axi_aclk)
    begin
        if(~s00_axi_aresetn)
        begin
            clear_memory <= 0;
            image_capture_enabled <= 0;
        end
        else
        begin
            if(s00_axi_wstrb[0] || s00_axi_wvalid)
            begin
                if(s00_axi_wdata == START_IMAGE_CAPTURE_COMMAND)
                begin
                    clear_memory <= 0;
                    image_capture_enabled <= 1;
                end
                else if(s00_axi_wdata == STOP_IMAGE_CAPTURE_COMMAND)
                begin
                     clear_memory <= 1;
                     image_capture_enabled <= 0;
                end
            end
            else
                clear_memory <= 0;
        end
    end
	// User logic ends
	endmodule
