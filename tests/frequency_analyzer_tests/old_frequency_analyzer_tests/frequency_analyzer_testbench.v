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
`define VALUE_NOT_SET 0

module frequency_analyzer_testbench #
(
    parameter DEFAULT_FREQUENCY0 = 9000,
    parameter DEFAULT_FREQUENCY1 = 11000,
    parameter DEFAULT_FREQUENCY0_DEVIATION = 20,
    parameter DEFAULT_FREQUENCY1_DEVIATION = 20,
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

    frequency_analyzer #(.DEFAULT_FREQUENCY0(DEFAULT_FREQUENCY0), .DEFAULT_FREQUENCY1(DEFAULT_FREQUENCY1), 
                         .DEFAULT_FREQUENCY0_DEVIATION(DEFAULT_FREQUENCY0_DEVIATION), 
                         .DEFAULT_FREQUENCY1_DEVIATION(DEFAULT_FREQUENCY1_DEVIATION), 
                         .CLOCK_FREQUENCYK(CLOCK_FREQUENCY)) 
    frequency_analyzer_test (.sample_data(sample_data), .clock(clock), .enable(enable),
                             .clear(clear), .f0(`VALUE_NOT_SET), .f1(`VALUE_NOT_SET), .deviation(`VALUE_NOT_SET),
                             .f0_value(f0_value), .f1_value(f1_value));

endmodule