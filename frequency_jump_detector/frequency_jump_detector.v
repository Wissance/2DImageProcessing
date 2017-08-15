`timescale 1 ns / 1 ps

module frequency_jump_detector #
(
    parameter pixel_number = 0,
    parameter period_1, /* нс */
    parameter period_2, /* нс */
    parameter period_3, /* нс */
    parameter tolerance /* нс */
)
(
    input wire pixel_clock,
    input wire reset,
    input wire enable,
    output wire jump_detected,
    input wire lval,
    input wire[7:0] pixel
);

localparam period_50MHz = 20;
reg[11:0] pixel_counter;
reg measure_time;
reg[31:0] elapsed_time;

reg[1:0] current_frequency;
localparam FREQUENCY_UNKNOWN = 2'b00;
localparam FREQUENCY_1 = 2'b01;
localparam FREQUENCY_2 = 2'b10;
localparam FREQUENCY_3 = 2'b11;

always@(posedge pixel_clock) begin
    if(!reset) begin
        pixel_counter <= 0;
        measure_time <= 1'b0;
        elapsed_time <= 0;
        current_frequency <= FREQUENCY_UNKNOWN;
    end
    
    else begin
        if(enable) begin
            if(lval) begin
                pixel_counter <= pixel_counter + 1;
                
                if(measure_time)
                    elapsed_time <= elapsed_time + period_50MHz;
                
                if(pixel_counter == pixel_number) begin
                    if(pixel != 0) begin
                        if(!measure_time) begin
                            measure_time <= 1'b1;
                            elapsed_time <= elapsed_time + period_50MHz;
                        end
                        
                        else begin
							/* Сбрасываем время. */
							elapsed_time <= 0;
						
							/* Время между импульсами приблизительно соответствует периоду частоты 1. */
                            if(elapsed_time >= period_1 - tolerance && elapsed_time <= period_1 + tolerance) begin
                                if(current_frequency != FREQUENCY_UNKNOWN && current_frequency != FREQUENCY_1)
                                    jump_detected <= 1'b1;
                                    
                                current_frequency <= FREQUENCY_1;
                            end
                            
							/* Время между импульсами приблизительно соответствует периоду частоты 2. */
                            else if(elapsed_time >= period_2 - tolerance && elapsed_time <= period_2 + tolerance) begin
                                if(current_frequency != FREQUENCY_UNKNOWN && current_frequency != FREQUENCY_2)
                                    jump_detected <= 1'b1;

                                current_frequency <= FREQUENCY_2;                               
                            end
                            
							/* Время между импульсами приблизительно соответствует периоду частоты 3. */
                            else if(elapsed_time >= period_3 - tolerance && elapsed_time <= period_3 + tolerance) begin
                                if(current_frequency != FREQUENCY_UNKNOWN && current_frequency != FREQUENCY_3)
                                    jump_detected <= 1'b1;
                            
                                current_frequency <= FREQUENCY_3;
                            end
                            
							/* Промежуток оказался слижком коротким, либо длинным. */
                            /* else begin
								jump_detected <= 1'b1;
								current_frequency <= FREQUENCY_UNKNOWN;
                            end
							*/
                        end
                    end
                end
                
                else begin
                    jump_detected <= 1'b0;
                end
            end
            
            else begin
                pixel_counter <= 0;
            end
        end
    end
end

endmodule