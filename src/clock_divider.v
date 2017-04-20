`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EasySoft Group
// Engineer: Ushakov M.V. (EvilLord666)
// 
// Create Date: 04.10.2016 05:53:55
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: Zynq-7k
// Tool Versions: Vivado 2016.2
// Description: Module for programmable clock division from 1 till 255
// 
// Dependencies: 
// 
// Revision: 
// Revision 1.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider #
(
    parameter clock_division = 2
)
(
    input wire reset,
    input wire input_clock,
    output wire output_clock
); 
    reg[7:0] counter;
    reg output_clock_value;
    
    assign output_clock =  clock_division == 1 ? input_clock & reset : output_clock_value; 

    
    always @(posedge input_clock)
    begin
         if(~reset)
         begin
             counter <= 0;
             output_clock_value <= 0;
         end
         else
         begin
             if(counter == clock_division - 1)
             begin
                 output_clock_value <= ~output_clock_value;
                 counter <= 1;
             end
             else
                 counter <= counter + 1;
         end
    end
    
endmodule
