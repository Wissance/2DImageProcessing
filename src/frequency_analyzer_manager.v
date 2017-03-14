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


module frequency_analyzer_manager(
    input wire [7:0] data,
    input wire clock,
    input wire pixel_clock,
    input wire enable,
    input wire clear
    // todo: umv: add outputs i.e. via AXI as SLAVE
    );
    
    // todo: set it from image_capture_manager
    localparam integer pixel_0_index = 15;
    localparam integer pixel_1_index = 511;
    localparam integer pixel_2_index = 1023;
    
    reg pixel_0_sample_data;
    reg pixel_1_sample_data;
    reg pixel_2_sample_data;
    reg [9:0] pixel_counter;
    
    integer pixel_0_f1_action_time;
    integer pixel_0_f2_action_time;
    integer pixel_1_f1_action_time;
    integer pixel_1_f2_action_time;
    integer pixel_2_f1_action_time;
    integer pixel_2_f2_action_time;
    
    //todo: umv: set proper frequencies
    freaquency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .DEVIATION(10), .CLOCK(1000000)) 
         pixel_0_analyzer(.sample_data(pixel_0_sample_data), .clock(clock), .enable(enable), .clear(clear), 
                          .f1_value(pixel_0_f1_action_time), .f2_value(pixel_0_f2_action_time));
    freaquency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .DEVIATION(10), .CLOCK(1000000)) 
         pixel_1_analyzer(.sample_data(pixel_0_sample_data), .clock(clock), .enable(enable), .clear(clear),
                          .f1_value(pixel_1_f1_action_time), .f2_value(pixel_1_f2_action_time));
    freaquency_analyzer #(.FREQUENCY_1(9000), .FREQUENCY_2(11000), .DEVIATION(10), .CLOCK(1000000)) 
         pixel_2_analyzer(.sample_data(pixel_0_sample_data), .clock(clock), .enable(enable), .clear(clear),
                          .f1_value(pixel_2_f1_action_time), .f2_value(pixel_2_f2_action_time));
    
    always @(posedge pixel_clock)
    begin
        if(clear)
        begin
            pixel_0_sample_data <= 0;
            pixel_1_sample_data <= 0;
            pixel_2_sample_data <= 0;
            pixel_counter <= 0;
        end
        else
        begin
            if(enable)
            begin
                pixel_counter <= pixel_counter + 1;
                if(pixel_counter == pixel_0_index)
                    pixel_0_sample_data <= data[7];
                else if (pixel_counter == pixel_1_index)
                    pixel_1_sample_data = data[7];
                else if (pixel_counter == pixel_2_index)
                    pixel_2_sample_data = data[7];
            end
        end
    end
    
endmodule
