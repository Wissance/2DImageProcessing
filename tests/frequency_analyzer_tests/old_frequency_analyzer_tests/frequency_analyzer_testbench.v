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
    parameter FREQUENCY0 = 9000,
    parameter FREQUENCY1 = 11000,
    parameter FREQUENCY0_DEVIATION = 20,
    parameter FREQUENCY1_DEVIATION = 20,
    parameter CLOCK_FREQUENCY = 50000000
)
(
    input wire sample_data,
    input wire clock,
    input wire enable,
    input wire clear,
    output wire[31:0] f0_value,
    output wire[31:0] f1_value
);

    frequency_analyzer #(.FREQUENCY0(FREQUENCY0), .FREQUENCY1(FREQUENCY1), 
                         .FREQUENCY0_DEVIATION(FREQUENCY0_DEVIATION), 
                         .FREQUENCY1_DEVIATION(FREQUENCY1_DEVIATION), 
                         .CLOCK_FREQUENCYK(CLOCK_FREQUENCY)) 
    frequency_analyzer_test (.sample_data(sample_data), .clock(clock), .enable(enable),
                             .clear(clear), .f0_value(f0_value), .f1_value(f1_value));

endmodule