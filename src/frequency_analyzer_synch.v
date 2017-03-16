`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 23:31:58
// Design Name: 
// Module Name: frequency_analyzer_synch
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


module frequency_analyzer_synch #
(
    parameter integer CLOCK = 100000000,
    parameter integer FREQUENCY = 2000
)
(
    input wire clock,
    input wire reset,
    input wire enable,
    output wire start_analyzer_0,
    output wire stop_analyzer_0,
    output wire start_analyzer_1,
    output wire stop_analyzer_1
);

    localparam integer frequency_ticks = CLOCK / FREQUENCY;
    localparam integer delay = 20;
    integer count;
    
    wire start_0_done;
    wire stop_0_done;
    wire start_1_done;
    wire stop_1_done;
    
    COUNTER_TC_MACRO #(.COUNT_BY(delay), .DEVICE("7SERIES"), .DIRECTION("UP"), .RESET_UPON_TC("FALSE"), .WIDTH_DATA(32))
    start_0_counter(.TC(start_0_done), .CLK(clock), .CE(enable), .RST(reset | stop_1_done));
     
    COUNTER_TC_MACRO #(.COUNT_BY(frequency_ticks), .DEVICE("7SERIES"), .DIRECTION("UP"), .RESET_UPON_TC("FALSE"), .WIDTH_DATA(32))
    stop_0_counter(.TC(stop_0_done), .CLK(clock), .CE(enable & start_0_done), .RST(reset | stop_1_done));

    COUNTER_TC_MACRO #(.COUNT_BY(frequency_ticks), .DEVICE("7SERIES"), .DIRECTION("UP"), .RESET_UPON_TC("FALSE"), .WIDTH_DATA(32))
    start_1_counter(.TC(start_1_done), .CLK(clock), .CE(enable & stop_0_done), .RST(reset | stop_1_done));
    
    COUNTER_TC_MACRO #(.COUNT_BY(delay), .DEVICE("7SERIES"), .DIRECTION("UP"), .RESET_UPON_TC("FALSE"), .WIDTH_DATA(32))
    stop_1_counter(.TC(stop_1_done), .CLK(clock), .CE(enable & start_1_done), .RST(reset));
    
    assign start_analyzer_0 = enable ? ~start_0_done : 0;
    assign stop_analyzer_0 = enable ? stop_0_done & ~start_1_done : 0;
    assign start_analyzer_1 = enable ? ~start_1_done : 0;
    assign stop_analyzer_1 = enable ? ~stop_1_done & ~start_0_done : 0;

endmodule
