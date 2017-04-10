`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2016 16:55:54
// Design Name: 
// Module Name: frequency_analyzer_testbench
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


module frequency_analyzer_synch_testbench #
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

frequency_analyzer_synch #(.FREQUENCY(FREQUENCY), .CLOCK(CLOCK)) 
testing_frequency_analyzer_synch (.clock(clock), .enable(enable), .reset(reset), 
                               .start_analyzer_0(start_analyzer_0), .stop_analyzer_0(stop_analyzer_0),
							   .start_analyzer_1(start_analyzer_1), .stop_analyzer_1(stop_analyzer_1));

endmodule