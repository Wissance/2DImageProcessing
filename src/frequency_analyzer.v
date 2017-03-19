`timescale 1ns / 1ps

module frequency_analyzer #
(
    // FREQUENCY_2 MUST ALWAYS BE GREATER THAN FREQUENCY_1
    parameter FREQUENCY_1 = 9000,        // i.e. 9  kHz
    parameter FREQUENCY_2 = 11000,       // i.e. 11 kHz
    parameter FREQUENCY_DEVIATION = 10,  // in percents
    parameter CLOCK = 50000000           // i.e. 50 MHz
)
(
    input wire sample_data,
    input wire clock,
    input wire enable,
    input wire clear,
    output wire[31:0] f1_value,
    output wire[31:0] f2_value
);

integer frequency1_ticks = CLOCK / (2 * FREQUENCY_1);
integer frequency2_ticks = CLOCK / (2 * FREQUENCY_2);
integer frequency1_deviation = 0;
integer frequency2_deviation = 0;
integer frequency_counter = 0;
integer frequency1_counter = 0;
integer frequency2_counter = 0;
reg start_sample_value;
reg[1:0] check_result;

assign f1_value = frequency1_counter;
assign f2_value = frequency2_counter;

initial
begin
    start_sample_value = 0;
    frequency1_deviation = frequency1_ticks / FREQUENCY_DEVIATION;
    frequency2_deviation = frequency2_ticks / FREQUENCY_DEVIATION;
end

always @(posedge clock or posedge clear)
begin
    if(~clear)
    begin
        start_sample_value = 0;
        frequency1_counter = 0;
        frequency2_counter = 0;
        frequency_counter = 0;
    end
    else
    begin
        if(enable)
        begin
            if(frequency_counter == 0)
            begin
                start_sample_value = sample_data;
            end
            else
            begin
                if(sample_data != start_sample_value)
                begin
                    start_sample_value = sample_data;
                    check_result = check_frequency(frequency_counter);
                    if(check_result == 1)
                        frequency2_counter = frequency2_counter +  frequency_counter;
                    else if(check_result == 2)
                        frequency1_counter = frequency1_counter +  frequency_counter;
                frequency_counter = 0;
                end
            end
            frequency_counter = frequency_counter + 1;
        end
    end
end

function[1:0] check_frequency;
input integer frequency;
reg[1:0] result;
begin
    //todo: umv: first approach frequency could have deviation
    if(frequency >= frequency1_ticks - frequency1_deviation && frequency <= frequency1_ticks + frequency1_deviation)
        result = 1;
    else if(frequency >= frequency2_ticks - frequency2_deviation && frequency <= frequency2_ticks + frequency2_deviation)
        result = 2;
    else result = 0;
    check_frequency = result;
end
endfunction
endmodule
