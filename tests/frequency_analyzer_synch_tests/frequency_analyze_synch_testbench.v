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


module frequency_analyzer_synch_testbench;

reg clock;
reg reset;
reg enable;
wire start_analyzer_0;
wire stop_analyzer_0;
wire start_analyzer_1;
wire stop_analyzer_1;

frequency_analyzer_synch #(.FREQUENCY(2000), .CLOCK(100000000)) f(
    .clock(clock),
    .enable(enable),
    .reset(reset), 
    .start_analyzer_0(start_analyzer_0),
    .stop_analyzer_0(stop_analyzer_0),
    .start_analyzer_1(start_analyzer_1),
    .stop_analyzer_1(stop_analyzer_1));

    initial begin
        clock <= 1'b0;
        reset <= 1'b0;
        enable <= 1'b0;
        
        reset <= #10 1'b1;
        enable <= #10 1'b1;
    end
    
    always #5 clock <= ~clock;

endmodule