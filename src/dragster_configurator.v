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
    reg [1:0] slave;
    reg enable;
    reg start_transaction;
    wire end_of_transaction;
    //supply1 vcc;

/*    wire internal_reset_n;
    wire internal_reset_clk;

    assign internal_reset_clk = clk & !internal_reset_n;*/
    
    // enable generator 
    //FDRE reset_generator(.R(reset_n), .CE(vcc), .D(vcc), .C(clk), .Q(internal_reset));
    //FDCE reset_generator(.CLR(~reset_n), .CE(vcc), .D(vcc), .C(clk), .Q(internal_reset_n));
    //FDRE enable_generator(.R(enable), .CE(~busy & ~configuration_done & reset_n), .D(vcc), .C(clk), .Q(enable));
    
    quick_spi spi_iml(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .start_transaction(start_transaction),
        .slave(slave),
        .incoming_data(incoming_data),
        .outgoing_data(command_buffer),
        .operation(1'b1),
        .end_of_transaction(end_of_transaction),
        .miso(miso),
        .sclk(sclk),
        .ss_n(ss_n),
        .mosi(mosi));
    
    /*always@(negedge reset_n
            //posedge internal_reset_clk 
            or posedge enable)
    begin
        if(~reset_n)
           //~internal_reset_n)
        begin
            register_counter = 0;
            configuration_done = 0;
            command_buffer = 0;
            slave = 0;
        end
        else //if(enable)
        begin
            register_counter = register_counter + 1;
            command_buffer = get_dragster_config(register_counter - 1);
            if(register_counter == 4)
            begin
                //todo: umv: add dragster 1 configuring
                configuration_done = 1;
            end
        end
    end*/
    
    always @ (posedge clk) begin
        if(!reset_n) begin
            register_counter <= 0;
        end
        
        else begin
            if(!register_counter) begin
                enable <= 1'b1;
                start_transaction <= 1'b1;
                command_buffer <= get_dragster_config(register_counter);
                register_counter <= register_counter + 1;
            end
                
            if(end_of_transaction) begin
                if(register_counter < 4) begin
                    command_buffer <= get_dragster_config(register_counter);
                    register_counter <= register_counter + 1;
                end
            
                if(register_counter == 4) begin
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
           0:
           begin
               // control register 2
               result = 16'b0100000001001100; 
           end
           1:
           begin
               // control register 3
               result = 16'b1010000011001000; 
           end
           2:
           begin
               // end of range
               result = 16'b0001000010010000;
           end
           3:
           begin
               // control register 1
               result = 16'b1000000010010101; 
           end
           default:
           begin
               result = 16'b0000000000000000;
           end
       endcase
       get_dragster_config = result;
    end
    endfunction
endmodule
