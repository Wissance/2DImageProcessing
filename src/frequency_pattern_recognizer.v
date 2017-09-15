`timescale 1ns / 1ps

module frequency_pattern_recognizer #
(
    parameter DATA_WIDTH = 8,
	parameter SAMPLES_QUANTITY = 25
)
(
    input wire clk,
	input wire reset,
	input wire [DATA_WIDTH - 1 : 0] data [SAMPLES_QUANTITY - 1 : 0],  // data in format like: 3-2-2-2-1-3
	output reg [DATA_WIDTH - 1 : 0] frequency_jump_index,
	output reg scanning_completed
);

    always @(posedge clk)
    begin
	    if(reset)
		begin
		end
		else
		begin
		end
	end

endmodule