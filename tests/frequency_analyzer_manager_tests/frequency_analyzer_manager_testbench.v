module frequency_analyzer_manager_testbench #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 10,
    parameter integer PIXEL0_INDEX = 2,
    parameter integer PIXEL1_INDEX = 1000,
    parameter integer PIXEL2_INDEX = 2000,
    parameter integer PIXEL0_FREQUENCY0 = 5000,
    parameter integer PIXEL0_FREQUENCY1 = 10000,
    parameter integer PIXEL1_FREQUENCY0 = 14000,
    parameter integer PIXEL1_FREQUENCY1 = 50000,
    parameter integer PIXEL2_FREQUENCY0 = 70000,
    parameter integer PIXEL2_FREQUENCY1 = 80000,
    parameter integer FREQUENCY_DEVIATION = 20,
    parameter integer CLOCK_FREQUENCY = 100000000,
    parameter integer THRESHOLD_VALUE = 100,
    parameter integer DARK_PIXELS_COUNT = 32
)
(
    input wire [7:0] data,
    input wire pixel_clock,
    input wire start,
    input wire stop,
    input wire clear,
    output wire irq,
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

    frequency_analyzer_manager #
	(
	    .C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.PIXEL0_INDEX(PIXEL0_INDEX),
		.PIXEL1_INDEX(PIXEL1_INDEX),
		.PIXEL2_INDEX(PIXEL2_INDEX),
		.PIXEL0_FREQUENCY0(PIXEL0_FREQUENCY0),
        .PIXEL0_FREQUENCY1(PIXEL0_FREQUENCY1),
        .PIXEL1_FREQUENCY0(PIXEL1_FREQUENCY0),
        .PIXEL1_FREQUENCY1(PIXEL1_FREQUENCY1),
        .PIXEL2_FREQUENCY0(PIXEL2_FREQUENCY0),
        .PIXEL2_FREQUENCY1(PIXEL2_FREQUENCY1),
        .FREQUENCY_DEVIATION(FREQUENCY_DEVIATION),
        .CLOCK_FREQUENCY(CLOCK_FREQUENCY),
        .THRESHOLD_VALUE(THRESHOLD_VALUE),
        .DARK_PIXELS_COUNT(DARK_PIXELS_COUNT)
	) 
	testing_frequency_analyzer_manager
	(
	    .data(data),
        .pixel_clock(pixel_clock),
        .start(start),
        .stop(stop),
        .clear(clear),
        .irq(irq),
         // Ports of Axi Slave Bus Interface S00_AXI
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awprot(s00_axi_awprot),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_awready(s00_axi_awready),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_bresp(s00_axi_bresp),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_arprot(s00_axi_arprot),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_arready(s00_axi_arready),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rresp(s00_axi_rresp),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_rready(s00_axi_rready)
	);

endmodule