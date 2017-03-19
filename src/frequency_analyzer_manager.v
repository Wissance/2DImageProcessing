`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2017 05:12:24 PM
// Design Name: 
// Module Name: frequency_analyzer_manager
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frequency_analyzer_manager #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 10
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
    
    // todo: set it from image_capture_manager
    localparam integer pixel_0_index = 15;
    localparam integer pixel_1_index = 511;
    localparam integer pixel_2_index = 1023;
    localparam integer registers_number = 6;
    
    // frequency analyzer data
    reg pixel_0_sample_data;
    reg pixel_1_sample_data;
    reg pixel_2_sample_data;
    reg [9:0] pixel_counter;
    wire enable;
    // axi register access
    reg[31:0] register_write;
    reg[1:0] register_operation;
    reg[7:0] register_number;
    wire[31:0] register_read;
    reg[2:0] register_counter;
    reg write_completed;
    
    // frequency analyzer frequencies times
    reg [31:0] pixel_0_f1_action_time;
    reg [31:0] pixel_0_f2_action_time;
    reg [31:0] pixel_1_f1_action_time;
    reg [31:0] pixel_1_f2_action_time;
    reg [31:0] pixel_2_f1_action_time;
    reg [31:0] pixel_2_f2_action_time;    
    wire [31:0] pixel_0_f1_action_time_net;
    wire [31:0] pixel_0_f2_action_time_net;
    wire [31:0] pixel_1_f1_action_time_net;
    wire [31:0] pixel_1_f2_action_time_net;
    wire [31:0] pixel_2_f1_action_time_net;
    wire [31:0] pixel_2_f2_action_time_net;
    
    always @(*)
    begin
        pixel_0_f1_action_time = pixel_0_f1_action_time_net;
        pixel_0_f2_action_time = pixel_0_f2_action_time_net;
        pixel_1_f1_action_time = pixel_1_f1_action_time_net;
        pixel_1_f2_action_time = pixel_1_f2_action_time_net;
        pixel_2_f1_action_time = pixel_2_f1_action_time_net;
        pixel_2_f2_action_time = pixel_2_f2_action_time_net;
    end
    
    // enable generator
    FDCE #(.INIT(0)) enable_generator(.C(s00_axi_aclk), .CE(s00_axi_aresetn), .D(start), .Q(enable), .CLR(stop));
    //todo: umv: set proper frequencies
    frequency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .FREQUENCY_DEVIATION(10), .CLOCK(100000000)) 
         pixel_0_analyzer(.sample_data(pixel_0_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear), 
                          .f1_value(pixel_0_f1_action_time_net), .f2_value(pixel_0_f2_action_time_net));
    frequency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .FREQUENCY_DEVIATION(10), .CLOCK(100000000)) 
         pixel_1_analyzer(.sample_data(pixel_0_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear),
                          .f1_value(pixel_1_f1_action_time_net), .f2_value(pixel_1_f2_action_time_net));
    frequency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .FREQUENCY_DEVIATION(10), .CLOCK(100000000)) 
         pixel_2_analyzer(.sample_data(pixel_0_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear),
                          .f1_value(pixel_2_f1_action_time_net), .f2_value(pixel_2_f2_action_time_net));
    assign irg = stop;
    // Instantiation of Axi Bus Interface S00_AXI
    axi_slave_impl # 
    ( 
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
        .NUMBER_OF_REGISTERS(registers_number)
    ) 
    frequency_analyzer_manager_inst 
    (
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
        .register_operation(register_operation),
        .register_number(register_number),
        .register_read(register_read),
        .register_write(register_write)
    );
    
    always @(posedge pixel_clock)
    begin
        if(~clear || ~s00_axi_aresetn)
        begin
            pixel_0_sample_data <= 0;
            pixel_1_sample_data <= 0;
            pixel_2_sample_data <= 0;
            pixel_counter <= 0;
        end
        else
        begin
            if(enable)
            begin
                pixel_counter <= pixel_counter + 1;
                if(pixel_counter == pixel_0_index)
                    pixel_0_sample_data <= data[7];
                else if (pixel_counter == pixel_1_index)
                    pixel_1_sample_data = data[7];
                else if (pixel_counter == pixel_2_index)
                    pixel_2_sample_data = data[7];
            end
        end
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if(stop && ~write_completed)
        for(register_counter = 0; register_counter < registers_number; register_counter = register_counter + 1)
        begin
            register_operation <= 2;//`REGISTER_WRITE_OPERATION;
            register_number <= register_counter + 1;
            register_write <= 33; //todo: umv emulation, add function get_frequency(number)
            if(register_counter == registers_number - 1)
                write_completed <= 1;
        end
        if(stop && write_completed)
        begin
            register_operation <= 0;
            register_number <= 0;
            register_write <= 0;
        end
        if(~stop)
        begin
            register_operation <= 0;
            register_number <= 0;
            register_write <= 0;
            write_completed <= 0;
        end
    end
    
endmodule
