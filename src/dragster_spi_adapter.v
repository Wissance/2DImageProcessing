`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2017 02:00:33
// Design Name: 
// Module Name: dragster_spi_adapter
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


module dragster_spi_adapter #
(
    EXTENDED_CLOCKS = 3,
	TRANSACTION_DEPTH = 128,
	DATA_WIDTH = 16
)
(
    input wire clk,
    input wire reset,
    input wire internal_mosi,
    output wire internal_miso,
    input wire internal_sck,
    input wire[1:0] internal_ss,
    
    output reg external_mosi,
    input wire external_miso,
    output wire external_sck,
    output reg[1:0] external_ss
	);

/* Мы не можем делать селекты на памяти, поэтому для этого дела будет выделен отдельный регистр. */
reg[DATA_WIDTH - 1 : 0] transactions[TRANSACTION_DEPTH - 1 : 0];

/* Получатели. */
reg[1:0] slaves[TRANSACTION_DEPTH - 1 : 0];

/* Регистр для анализа данных. Здесь мы делаем селект и уточняем тип операции, проверяя адресный байт на наличие значения 15. */
//reg[15:0] transaction;

/* Счетчики бит */
reg[3:0] bit_counter;
reg[3:0] internal_bit_count;
reg[7:0] external_clock_count;
reg generate_external_clock;

reg clock_enable;

/* Количество буферизированных транзакций. */
reg[7:0] buffered_transaction_count;

/* Количество транзакций отправленных в сенсор. */
reg[7:0] forwarded_transaction_count;

/* Индекс транзакции буферизируемой в данный момент. Отсюда мы читать не будем. */
reg[7:0] transaction_about_to_be_buffered;

integer counter;

assign external_sck = clock_enable ? clk : 0;

/* always по клоку источника */
always @ (negedge clk)
begin
    if(!reset) 
    begin
        forwarded_transaction_count <= 0;
        bit_counter <= 0;
        external_mosi <= 0;
        external_ss <= 3;
		clock_enable <= 0;
		generate_external_clock <= 0;
		external_clock_count <= 0;
    end
    
    else 
    begin
        if(buffered_transaction_count > 0 && forwarded_transaction_count < buffered_transaction_count) 
        begin
		    clock_enable <= 1;
			
		    if(clock_enable && ~generate_external_clock)
			begin
			    bit_counter <= bit_counter + 1;
                external_ss <= slaves[forwarded_transaction_count];
				external_mosi <= transactions[forwarded_transaction_count][bit_counter];             
                if(bit_counter == DATA_WIDTH - 1)
				    generate_external_clock <= 1;
			end
			else
			begin
			    external_clock_count <= external_clock_count + 1;
				if(EXTENDED_CLOCKS == 0 || external_clock_count == EXTENDED_CLOCKS)
				begin
				    external_clock_count <= 0;
					generate_external_clock <= 0;
					clock_enable <= 0;
					external_ss <= 3;
					external_mosi <= 0;
					if(forwarded_transaction_count == TRANSACTION_DEPTH - 1)
					    forwarded_transaction_count <= 0;
					else forwarded_transaction_count <= forwarded_transaction_count + 1;
					bit_counter <= 0;
				end
			end
        end
    end
end

/* Индекс бита. */
//reg[5:0] bit_count;

/* Буфер в который мы складываем биты перед сохранением их в память. */
reg[15:0] internal_transaction_buffer;

/* always по клоку AXI Quad SPI */
always @ (negedge reset or negedge internal_sck)
begin
    if(!reset) 
    begin
        for(counter = 0; counter < TRANSACTION_DEPTH; counter = counter + 1)
        begin
            slaves[counter] = 3;
            transactions[counter] = 0;
        end
        buffered_transaction_count = 0;
		internal_bit_count = 0;
    end
    else
    begin
	    internal_bit_count = internal_bit_count + 1;
        internal_transaction_buffer[internal_bit_count - 1] = internal_mosi;
   
        if(internal_bit_count == 0) //DATA_WIDTH - 1)
        begin
		    internal_transaction_buffer[15] = internal_mosi;
            transactions[buffered_transaction_count] = internal_transaction_buffer;
            slaves[buffered_transaction_count] = internal_ss;
            if(buffered_transaction_count == TRANSACTION_DEPTH - 1)
                buffered_transaction_count = 0;
            else buffered_transaction_count = buffered_transaction_count + 1;
			internal_bit_count = 0;
        end
    end
end

endmodule
