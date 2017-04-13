`timescale 1ns / 1ps

module frequency_analyzer #
(
    // FREQUENCY_2 MUST ALWAYS BE GREATER THAN FREQUENCY_1
    parameter FREQUENCY0 = 9000,                   // i.e. 9  kHz
    parameter FREQUENCY1 = 11000,                  // i.e. 11 kHz
    parameter FREQUENCY0_DEVIATION = 10,           // in percents
    parameter FREQUENCY1_DEVIATION = 10,           // in percents
    parameter CLOCK_FREQUENCY = 50000000           // i.e. 50 MHz
)
(
    input wire sample_data,
    input wire clock,
    input wire enable,
    input wire clear,
    output wire[31:0] f0_value,
    output wire[31:0] f1_value
);

localparam integer frequency0_ticks = CLOCK_FREQUENCY / (2 * FREQUENCY0);
localparam integer frequency1_ticks = CLOCK_FREQUENCY / (2 * FREQUENCY1);

localparam integer frequency0_deviation = (frequency0_ticks * FREQUENCY0_DEVIATION) / 100;
localparam integer frequency1_deviation = (frequency1_ticks * FREQUENCY1_DEVIATION) / 100;

reg[31:0] frequency_counter = 0;
reg[31:0] frequency0_counter = 0;
reg[31:0] frequency1_counter = 0;

reg start_sample_value;
reg[1:0] check_result;

assign f0_value = frequency0_counter;
assign f1_value = frequency1_counter;

initial
begin
    frequency_counter = 0;
    frequency0_counter = 0;
    frequency1_counter = 0;
end

always @(posedge clock) 
begin
    if(!clear) 
    begin
        start_sample_value = 0;
        frequency0_counter = 0;
        frequency1_counter = 0;
        frequency_counter = 0;
        check_result = 0;
    end
    
    else  
    if(enable) 
    begin
        if(frequency_counter == 0)
            start_sample_value = sample_data;
            
        else if(sample_data != start_sample_value) 
        begin
            start_sample_value = sample_data;
            check_result = check_frequency(frequency_counter);
                
            if(check_result == 2)
                frequency1_counter = frequency1_counter + frequency_counter;
            else if(check_result == 1)
                frequency0_counter = frequency0_counter + frequency_counter;                
            frequency_counter = 0;
        end        
        frequency_counter = frequency_counter + 1;
    end
end

function[1:0] check_frequency(input reg[31:0] frequency);
    reg[1:0] result;    
    begin
        //todo: umv: first approach frequency could have deviation
        if(frequency >= frequency0_ticks - frequency0_deviation && frequency <= frequency0_ticks + frequency0_deviation)
            result = 1;
        else if(frequency >= frequency1_ticks - frequency1_deviation && frequency <= frequency1_ticks + frequency1_deviation)
            result = 2;
        else result = 0;
        
        check_frequency = result;
    end
endfunction

endmodule
