//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Mon Jun 05 18:04:35 2017
//Host        : DLAB running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target image_processing_2d_design_wrapper.bd
//Design      : image_processing_2d_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module image_processing_2d_design_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    LINESCANNER0_DATA,
    LINESCANNER0_END_ADC,
    LINESCANNER0_LOAD_PULSE,
    LINESCANNER0_LVAL,
    LINESCANNER0_MAIN_CLOCK,
    LINESCANNER0_N_RESET,
    LINESCANNER0_PIXEL_CLOCK,
    LINESCANNER0_RST_CDS,
    LINESCANNER0_RST_CVC,
    LINESCANNER0_SAMPLE,
    LINESCANNER1_DATA,
    LINESCANNER1_END_ADC,
    LINESCANNER1_LOAD_PULSE,
    LINESCANNER1_LVAL,
    LINESCANNER1_MAIN_CLOCK,
    LINESCANNER1_N_RESET,
    LINESCANNER1_PIXEL_CLOCK,
    LINESCANNER1_RST_CDS,
    LINESCANNER1_RST_CVC,
    LINESCANNER1_SAMPLE,
    LINESCANNER_CLK,
    LINESCANNER_CS,
    LINESCANNER_MISO,
    LINESCANNER_MOSI);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [7:0]LINESCANNER0_DATA;
  input LINESCANNER0_END_ADC;
  output LINESCANNER0_LOAD_PULSE;
  input LINESCANNER0_LVAL;
  output LINESCANNER0_MAIN_CLOCK;
  output [0:0]LINESCANNER0_N_RESET;
  input LINESCANNER0_PIXEL_CLOCK;
  output LINESCANNER0_RST_CDS;
  output LINESCANNER0_RST_CVC;
  output LINESCANNER0_SAMPLE;
  input [7:0]LINESCANNER1_DATA;
  input LINESCANNER1_END_ADC;
  output LINESCANNER1_LOAD_PULSE;
  input LINESCANNER1_LVAL;
  output LINESCANNER1_MAIN_CLOCK;
  output [0:0]LINESCANNER1_N_RESET;
  input LINESCANNER1_PIXEL_CLOCK;
  output LINESCANNER1_RST_CDS;
  output LINESCANNER1_RST_CVC;
  output LINESCANNER1_SAMPLE;
  output LINESCANNER_CLK;
  output [1:0]LINESCANNER_CS;
  input LINESCANNER_MISO;
  output LINESCANNER_MOSI;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [7:0]LINESCANNER0_DATA;
  wire LINESCANNER0_END_ADC;
  wire LINESCANNER0_LOAD_PULSE;
  wire LINESCANNER0_LVAL;
  wire LINESCANNER0_MAIN_CLOCK;
  wire [0:0]LINESCANNER0_N_RESET;
  wire LINESCANNER0_PIXEL_CLOCK;
  wire LINESCANNER0_RST_CDS;
  wire LINESCANNER0_RST_CVC;
  wire LINESCANNER0_SAMPLE;
  wire [7:0]LINESCANNER1_DATA;
  wire LINESCANNER1_END_ADC;
  wire LINESCANNER1_LOAD_PULSE;
  wire LINESCANNER1_LVAL;
  wire LINESCANNER1_MAIN_CLOCK;
  wire [0:0]LINESCANNER1_N_RESET;
  wire LINESCANNER1_PIXEL_CLOCK;
  wire LINESCANNER1_RST_CDS;
  wire LINESCANNER1_RST_CVC;
  wire LINESCANNER1_SAMPLE;
  wire LINESCANNER_CLK;
  wire [1:0]LINESCANNER_CS;
  wire LINESCANNER_MISO;
  wire LINESCANNER_MOSI;

  image_processing_2d_design image_processing_2d_design_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .LINESCANNER0_DATA(LINESCANNER0_DATA),
        .LINESCANNER0_END_ADC(LINESCANNER0_END_ADC),
        .LINESCANNER0_LOAD_PULSE(LINESCANNER0_LOAD_PULSE),
        .LINESCANNER0_LVAL(LINESCANNER0_LVAL),
        .LINESCANNER0_MAIN_CLOCK(LINESCANNER0_MAIN_CLOCK),
        .LINESCANNER0_N_RESET(LINESCANNER0_N_RESET),
        .LINESCANNER0_PIXEL_CLOCK(LINESCANNER0_PIXEL_CLOCK),
        .LINESCANNER0_RST_CDS(LINESCANNER0_RST_CDS),
        .LINESCANNER0_RST_CVC(LINESCANNER0_RST_CVC),
        .LINESCANNER0_SAMPLE(LINESCANNER0_SAMPLE),
        .LINESCANNER1_DATA(LINESCANNER1_DATA),
        .LINESCANNER1_END_ADC(LINESCANNER1_END_ADC),
        .LINESCANNER1_LOAD_PULSE(LINESCANNER1_LOAD_PULSE),
        .LINESCANNER1_LVAL(LINESCANNER1_LVAL),
        .LINESCANNER1_MAIN_CLOCK(LINESCANNER1_MAIN_CLOCK),
        .LINESCANNER1_N_RESET(LINESCANNER1_N_RESET),
        .LINESCANNER1_PIXEL_CLOCK(LINESCANNER1_PIXEL_CLOCK),
        .LINESCANNER1_RST_CDS(LINESCANNER1_RST_CDS),
        .LINESCANNER1_RST_CVC(LINESCANNER1_RST_CVC),
        .LINESCANNER1_SAMPLE(LINESCANNER1_SAMPLE),
        .LINESCANNER_CLK(LINESCANNER_CLK),
        .LINESCANNER_CS(LINESCANNER_CS),
        .LINESCANNER_MISO(LINESCANNER_MISO),
        .LINESCANNER_MOSI(LINESCANNER_MOSI));
endmodule
