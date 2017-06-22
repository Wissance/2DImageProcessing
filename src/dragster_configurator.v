`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2017 13:28:22
// Design Name: 
// Module Name: dragster_configurator
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


module dragster_configurator #
(
)
(
    input clk,
    input reset_n,
    input wire miso,
    output wire mosi,
    output wire sclk,
    output wire[1:0] ss_n
);

    reg [15:0] command_buffer;
    wire[7:0] incoming_data;
    reg [3:0] register_counter;
    reg configuration_done;
    //reg [1:0] slave;
    reg enable;
    reg start_transaction;
    wire end_of_transaction;

    localparam NUMBER_OF_REGISTERS = 5;
    localparam REGISTER_MAX_INDEX = NUMBER_OF_REGISTERS - 1;
    
    quick_spi spi_iml(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .start_transaction(start_transaction),
        .slave(2'b00),//ss_n),//slave),
        .incoming_data(incoming_data),
        .outgoing_data(command_buffer),
        .operation(1'b1),
        .end_of_transaction(end_of_transaction),
        .miso(miso),
        .sclk(sclk),
        .ss_n(ss_n),
        .mosi(mosi));
    
    always @ (posedge clk)// or posedge end_of_transaction) 
    begin
        if(!reset_n) 
        begin
            register_counter <= 0;
            start_transaction <= 1'b0;
            enable <= 1'b0;
        end
        
        else 
        begin
            if(!register_counter) 
            begin
                enable <= 1'b1;
                start_transaction <= 1'b1;
                command_buffer <= get_dragster_config(register_counter);
                register_counter <= register_counter + 1;
            end
                
            if(end_of_transaction) 
            begin
                if(register_counter < NUMBER_OF_REGISTERS) 
                begin
                    command_buffer <= get_dragster_config(register_counter);
                    register_counter <= register_counter + 1;
                end
            
                if(register_counter == NUMBER_OF_REGISTERS)
                begin
                    enable <= 1'b0;
                    start_transaction <= 1'b0;
                end
            end
        end
    end
    
    function[15:0] get_dragster_config(reg [3:0] index);
    reg[15:0] result;
    begin
       case (index)  
           0: result = {8'b00111011, 8'b00000101};  // control register 3 (assress 5)
           1: result = {8'b00010010, 8'b00000010};  // control register 2 (address 2)
           2: result = {8'b10000000, 8'b00000011};  // inversed adc gain (address 3)
           3: result = {8'b00011111, 8'b00001001};  // end of adc register (assress 9)
           4: result = {8'b10100001, 8'b00000001};  // control register 1 (address 1) update bit
           default: result = 16'b0000000000000000;
       endcase
       get_dragster_config = result;
    end
    endfunction
endmodule
