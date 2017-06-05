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
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 10,
    parameter integer PIXEL0_INDEX = 2,
    parameter integer PIXEL1_INDEX = 256,
    parameter integer PIXEL2_INDEX = 768,
    parameter integer POINT0_FREQUENCY0 = 5000/*5000*/,/*2500 7500*/
    parameter integer POINT0_FREQUENCY1 = 10000,
    parameter integer POINT1_FREQUENCY0 = 15000,
    parameter integer POINT1_FREQUENCY1 = 20000,
    parameter integer POINT2_FREQUENCY0 = 25000,
    parameter integer POINT2_FREQUENCY1 = 30000,
    parameter integer FREQUENCY_DEVIATION = 30,
    parameter integer CLOCK_FREQUENCY = 100000000,
    parameter integer THRESHOLD_VALUE = 100,
    parameter integer TAP_DARK_PIXELS_COUNT = 16,      // for single TAP
    parameter integer TAP_COLOR_PIXELS_COUNT = 1024,   // for single TAP
    parameter integer POINT_WIDTH_PIXEL = 32
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
    
    localparam integer REGISTERS_NUMBER = 7;
    
    localparam POINT0_START_INDEX = TAP_DARK_PIXELS_COUNT + PIXEL0_INDEX;
    localparam POINT0_END_INDEX = POINT0_START_INDEX + POINT_WIDTH_PIXEL;
    
    localparam POINT1_START_INDEX = TAP_DARK_PIXELS_COUNT + PIXEL1_INDEX;
    localparam POINT1_END_INDEX = POINT1_START_INDEX + POINT_WIDTH_PIXEL;
    
    localparam POINT2_START_INDEX = TAP_DARK_PIXELS_COUNT + PIXEL2_INDEX;
    localparam POINT2_END_INDEX = POINT2_START_INDEX + POINT_WIDTH_PIXEL;
    
    // frequency analyzer data
    reg pixel0_sample_data;
    reg [7:0] max_point0_data;
    reg pixel1_sample_data;
    reg [7:0] max_point1_data;
    reg pixel2_sample_data;
    reg [7:0] max_point2_data;
    reg [11:0] pixel_counter;
    wire enable;
    // axi register access
    wire[31:0] register_write;
    wire[1:0] register_operation;
    wire[7:0] register_number;
    wire[31:0] register_read;
    reg write_completed;

    wire [31:0] pixel0_f0_action_time_net;
    wire [31:0] pixel0_f1_action_time_net;
    wire [31:0] pixel1_f0_action_time_net;
    wire [31:0] pixel1_f1_action_time_net;
    wire [31:0] pixel2_f0_action_time_net;
    wire [31:0] pixel2_f1_action_time_net;
    wire [31:0] pixel0_unknown_frequency;
    
    supply1 vcc;
    reg[31:0] register_write_value;
    reg[1:0] register_operation_value;
    reg[7:0] register_number_value;
    
    reg[1:0] hold;
    
    wire clear_impl;
    
    assign register_write = register_write_value;
    assign register_operation = register_operation_value;
    assign register_number = register_number_value;
    assign clear_impl = s00_axi_aresetn & 
                       ~write_completed & 
                       ~clear;
    
    // enable generator
    FDCE #(.INIT(0)) enable_generator(.C(start), .CE(s00_axi_aresetn), .D(vcc), .Q(enable), .CLR(stop));
    
    //todo: umv: set proper frequencies
    frequency_analyzer #(
        .FREQUENCY0(POINT0_FREQUENCY0),
        .FREQUENCY1(POINT0_FREQUENCY1), 
        .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION),
        .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
        .CLOCK_FREQUENCY(CLOCK_FREQUENCY)) 
        pixel0_analyzer(
            .sample_data(pixel0_sample_data),
            .clock(s00_axi_aclk),
            .enable(enable),
            .clear(clear_impl), 
            .f0_value(pixel0_f0_action_time_net),
            .f1_value(pixel0_f1_action_time_net),
            .unknown(pixel0_unknown_frequency));
                         
    frequency_analyzer #(
        .FREQUENCY0(POINT1_FREQUENCY0),
        .FREQUENCY1(POINT1_FREQUENCY1), 
        .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION),
        .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
        .CLOCK_FREQUENCY(CLOCK_FREQUENCY))
        pixel1_analyzer(
            .sample_data(pixel1_sample_data),
            .clock(s00_axi_aclk),
            .enable(enable),
            .clear(clear_impl),
            .f0_value(pixel1_f0_action_time_net),
            .f1_value(pixel1_f1_action_time_net));
                          
    frequency_analyzer #(
        .FREQUENCY0(POINT2_FREQUENCY0),
        .FREQUENCY1(POINT2_FREQUENCY1), 
        .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION),
        .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
        .CLOCK_FREQUENCY(CLOCK_FREQUENCY))
        pixel2_analyzer(
            .sample_data(pixel2_sample_data),
            .clock(s00_axi_aclk),
            .enable(enable),
            .clear(clear_impl),
            .f0_value(pixel2_f0_action_time_net),
            .f1_value(pixel2_f1_action_time_net));
            
    assign irq = write_completed;
    
    // Instantiation of Axi Bus Interface S00_AXI
    axi_slave_impl # 
    ( 
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
        .NUMBER_OF_REGISTERS(REGISTERS_NUMBER)
    ) 
    frequency_analyzer_manager_axi 
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
        if(~enable || write_completed)
        begin
            pixel0_sample_data <= 0;
            pixel1_sample_data <= 0;
            pixel2_sample_data <= 0;
            pixel_counter <= 0;
            
            max_point0_data <= 0;
            max_point1_data <= 0;
            max_point2_data <= 0;
        end
        else
        begin
            pixel_counter <= pixel_counter + 1;
            
            if(pixel_counter >= POINT0_START_INDEX && pixel_counter < POINT0_END_INDEX)
            begin
                if(max_point0_data < data)
                    max_point0_data <= data;
            end
            if(pixel_counter == POINT0_END_INDEX)
                pixel0_sample_data <= max_point0_data > THRESHOLD_VALUE ? 1'b1 : 1'b0; 
            
            if(pixel_counter >= POINT1_START_INDEX && pixel_counter < POINT1_END_INDEX)
            begin
                if(max_point1_data < data)
                    max_point1_data <= data;
            end
            if(pixel_counter == POINT1_END_INDEX)
                pixel1_sample_data <= max_point1_data > THRESHOLD_VALUE ? 1'b1 : 1'b0; 
            
            if(pixel_counter >= POINT2_START_INDEX && pixel_counter < POINT2_END_INDEX)
            begin
                if(max_point2_data < data)
                    max_point2_data <= data;
            end
            if(pixel_counter == POINT2_END_INDEX)
                pixel2_sample_data <= max_point2_data > THRESHOLD_VALUE ? 1'b1 : 1'b0;             
            
            if(pixel_counter >= TAP_COLOR_PIXELS_COUNT + TAP_DARK_PIXELS_COUNT)
            begin
                pixel_counter <= 0;
                max_point0_data <= 0;
                max_point1_data <= 0;
                max_point2_data <= 0;
            end
        end
    end
    
    always @(posedge s00_axi_aclk) 
    begin
        if(~s00_axi_aresetn)
        begin
           write_completed = 0;
           register_number_value = 0;
           hold = 0;
        end
        else
        begin
            if(stop)
            begin
                if(~write_completed)
                begin
                    if(hold == 0)
                    begin
                        register_number_value = register_number_value + 1;
                        if(register_number_value > 0 && register_number_value <= REGISTERS_NUMBER)
                        begin
                            register_operation_value = 2;//`REGISTER_WRITE_OPERATION;
                            register_write_value = get_frequency(register_number_value);//200 + register_number; 
                        end
                        if(register_number_value == REGISTERS_NUMBER + 1)
                            write_completed = 1;
                    end
                    hold = hold + 1;
                end
                else
                begin
                    register_operation_value = 0;
                    register_number_value = 0;
                    register_write_value = 0;
                end
            end
            else //if(!stop) 
            begin
                register_operation_value = 0;
                register_number_value = 0;
                register_write_value = 0;
                write_completed = 0;
                hold = 0;
            end
        end
    end
    
    function [31:0] get_frequency(input reg[3:0] index);
        case (index)
            1: get_frequency = pixel0_f0_action_time_net;
            2: get_frequency = pixel0_f1_action_time_net;
            3: get_frequency = pixel1_f0_action_time_net;
            4: get_frequency = pixel1_f1_action_time_net;
            5: get_frequency = pixel2_f0_action_time_net;
            6: get_frequency = pixel2_f1_action_time_net;
            7: get_frequency = pixel0_unknown_frequency;
            default: get_frequency = 0;
        endcase
    endfunction 
endmodule
