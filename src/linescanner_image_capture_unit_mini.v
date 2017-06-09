`timescale 1ns / 1ps

module linescanner_image_capture_unit_mini(
    input wire enable,
    input wire[7:0] data,
    output reg rst_cvc,
    output reg rst_cds,
    output reg sample,
    input wire end_adc,
    input wire lval,
    input wire pixel_clock,
    input wire main_clock_source,
    output wire main_clock,
    input wire n_reset,
    output wire[7:0] pixel_data,
    output wire pixel_captured);
    
    assign main_clock = main_clock_source;
    assign pixel_captured = lval ? pixel_clock : 0;
    assign pixel_data = data;
      
    localparam SM1_SEND_FE_OF_RST_CVC = 0;
    localparam SM1_SEND_FE_OF_RST_CDS = 1;
    localparam SM1_SEND_RE_OF_SAMPLE = 2;
    localparam SM1_SEND_FE_OF_SAMPLE = 3;
    localparam SM1_SEND_RE_OF_RST_CVC_AND_RST_CDS = 4;
    localparam SM1_WAIT_NUM_CLOCKS = 5;
    
    localparam clocks_per_microsecond_40_mhz = 38;
    localparam clocks_per_microsecond_50_mhz = 48;
    localparam clocks_per_microsecond_60_mhz = 58;
    localparam clocks_per_microsecond_70_mhz = 68;
    localparam clocks_per_microsecond_80_mhz = 78;
    localparam clocks_per_microsecond = clocks_per_microsecond_50_mhz;
      
    reg[7:0] sm1_state;
    reg[7:0] sm1_state_to_go_to_after_waiting;
    reg[7:0] sm1_num_clocks_to_wait;
    reg[7:0] sm1_clock_count;
    
    always @ (posedge pixel_clock) begin
        if(!n_reset) begin
            rst_cvc <= 1'b1;
            rst_cds <= 1'b1;
            sample <= 1'b0;
            
            sm1_state <= SM1_SEND_FE_OF_RST_CVC;
            sm1_state_to_go_to_after_waiting <= 0;
            sm1_num_clocks_to_wait <= 0;
            sm1_clock_count <= 0;
        end
        
        else
            case (sm1_state)
                SM1_SEND_FE_OF_RST_CVC:
                if(enable) begin
                    rst_cvc <= 1'b0;
                    
                    sm1_state <= SM1_WAIT_NUM_CLOCKS;
                    sm1_state_to_go_to_after_waiting <= SM1_SEND_FE_OF_RST_CDS;    
                    sm1_num_clocks_to_wait <= clocks_per_microsecond;
                end
                
                SM1_SEND_FE_OF_RST_CDS:
                begin
                    rst_cds <= 1'b0;
                     
                    sm1_state <= SM1_WAIT_NUM_CLOCKS;
                    sm1_state_to_go_to_after_waiting <= SM1_SEND_RE_OF_SAMPLE;
                    sm1_num_clocks_to_wait <= 7;
                end
                  
                SM1_SEND_RE_OF_SAMPLE:
                begin
                    if(end_adc) begin
                        sample <= 1'b1;
                    
                        sm1_state <= SM1_WAIT_NUM_CLOCKS;
                        sm1_state_to_go_to_after_waiting <= SM1_SEND_FE_OF_SAMPLE;
                        sm1_num_clocks_to_wait <= clocks_per_microsecond;
                    end
                end
                   
                SM1_SEND_FE_OF_SAMPLE:
                begin
                    sample <= 1'b0;
                    
                    sm1_state <= SM1_WAIT_NUM_CLOCKS;
                    sm1_state_to_go_to_after_waiting <= SM1_SEND_RE_OF_RST_CVC_AND_RST_CDS;
                    sm1_num_clocks_to_wait <= 6;
                end
                
                SM1_SEND_RE_OF_RST_CVC_AND_RST_CDS:
                begin
                    rst_cvc <= 1'b1;
                    rst_cds <= 1'b1;
                    
                    sm1_state <= SM1_SEND_FE_OF_RST_CVC;
                end
                
                SM1_WAIT_NUM_CLOCKS:
                if(sm1_clock_count < sm1_num_clocks_to_wait)
                    sm1_clock_count <= sm1_clock_count + 1;
                else begin
                    sm1_clock_count <= 0;
                    sm1_state <= sm1_state_to_go_to_after_waiting;
                end
            endcase
    end
endmodule
