`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2016 19:46:04
// Design Name: 
// Module Name: clock_divider_testbench
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


module clock_divider_testbench
(
    input input_clock,
    output output_clock_1,
    output output_clock_2,
    output output_clock_3,
    output output_clock_4
);

    clock_divider #(.clock_division(1)) divider_by_1  (.input_clock(input_clock), .output_clock(output_clock_1));
    clock_divider #(.clock_division(2)) divider_by_2  (.input_clock(input_clock), .output_clock(output_clock_2));
    clock_divider #(.clock_division(3)) divider_by_3  (.input_clock(input_clock), .output_clock(output_clock_3));
    clock_divider #(.clock_division(4)) divider_by_4  (.input_clock(input_clock), .output_clock(output_clock_4));
endmodule
