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


module frequency_analyzer_testbench;
    wire sample_data;
    reg clock;
    wire pixel_captured;
    reg incoming_data;
    
    reg enable;
    reg clear;
    
    wire[31:0] f0_value;
    wire[31:0] f1_value;
    
    assign pixel_captured = incoming_data & clock;

    frequency_analyzer #(
        .FREQUENCY0(5000),
        .FREQUENCY1(10000),
        .FREQUENCY0_DEVIATION(10),
        .FREQUENCY1_DEVIATION(10),
        .CLOCK_FREQUENCY(100000000)) f(
            .sample_data(sample_data),
            .clock(pixel_captured),
            .enable(enable),
            .clear(clear),
            .f0_value(f0_value),
            .f1_value(f1_value));

    initial begin
        clock <= 1'b0;
        clear <= 1'b0;
        enable <= 1'b0;
        incoming_data <= 1'b0; 
        
        clear <= #10 1'b1;
        enable <= #10 1'b1;
        incoming_data <= #100 1'b1;
    end

    always #5 clock <= ~clock;

endmodule