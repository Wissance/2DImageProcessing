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


module frequency_analyzer_testbench #
(
    // FREQUENCY_2 MUST ALWAYS BE GREATER THAN FREQUENCY_1
    parameter FREQUENCY_1 = 9000,    // i.e. 9  kHz
    parameter FREQUENCY_2 = 20000,   // i.e. 11 kHz
    parameter FREQUENCY_DEVIATION = 5,
    parameter CLOCK = 50000000       // i.e. 50 MHz
)
(
    input wire sample_data,
    input wire clock,
    input wire enable,
    input wire clear,
    output wire[31:0] f1_value,
    output wire[31:0] f2_value
);

frequency_analyzer #(.FREQUENCY_1(FREQUENCY_1), .FREQUENCY_2(FREQUENCY_2), .FREQUENCY_DEVIATION(FREQUENCY_DEVIATION), .CLOCK(CLOCK)) 
frequency_analyzer_test (.sample_data(sample_data), .clock(clock), .enable(enable),
                         .clear(clear), .f1_value(f1_value), .f2_value(f2_value));

endmodule