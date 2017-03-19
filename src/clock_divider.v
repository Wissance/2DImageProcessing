`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2016 05:53:55
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #
(
    parameter clock_division = 2
)
(
    input wire input_clock,
    output reg output_clock = 0
); 
    //reg[7:0] counter;
    
    //initial counter = 8'b00000000;
    
    integer counter = 0;

    
    if (clock_division == 1)
    begin            
        always@ (input_clock)
        begin
            output_clock <= input_clock;
        end
    end
    
    else
    begin
        always@ (posedge input_clock)
        begin
            counter = counter + 1;
            if(counter == clock_division)
            begin
                output_clock = ~output_clock;
                counter = 0;
            end
        end
    end
endmodule
