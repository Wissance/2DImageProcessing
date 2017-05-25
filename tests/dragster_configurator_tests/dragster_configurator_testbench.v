`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2017 15:04:02
// Design Name: 
// Module Name: dragster_configurator_testbench
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


module dragster_configurator_testbench
(
);
    reg clk;
    reg reset_n;
    wire miso;
    wire mosi;
    wire sclk;
    wire[1:0] ss_n;

    initial
    begin
        clk <= 0;
        reset_n <= 0;
        //reset_n <= #20 0;
        reset_n <= #200 1;
    end

    dragster_configurator configurator(.clk(clk), .reset_n(reset_n), 
                                       .miso(miso), .mosi(mosi), .sclk(sclk), .ss_n(ss_n));
    always #25 clk <= ~clk;

endmodule
