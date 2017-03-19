`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2016 17:20:34
// Design Name: 
// Module Name: fifo_testbench
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


module fifo_testbench
(
    input wire enable,
    input wire clear,
    output wire fifo_ready,
    input wire push_clock,
    input wire pop_clock,
    input wire [7 : 0] in_data,
    output wire [7 : 0] out_data,
    output wire popped_last,
    output wire pushed_last
);
//
fifo #(.FIFO_SIZE(3), .DATA_WIDTH(8)) simple_fifo (.enable(enable), .clear(clear), .fifo_ready(fifo_ready), 
                                                   .push_clock(push_clock), .pop_clock(pop_clock), 
                                                   .in_data(in_data), .out_data(out_data),
                                                   .popped_last(popped_last), .pushed_last(pushed_last));

endmodule
