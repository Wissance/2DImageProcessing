// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:linescanner_image_capture_unit_mini:1.0
// IP Revision: 1

(* X_CORE_INFO = "linescanner_image_capture_unit_mini,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "image_processing_2d_design_linescanner_image_capture_unit_mini_1_0,linescanner_image_capture_unit_mini,{}" *)
(* CORE_GENERATION_INFO = "image_processing_2d_design_linescanner_image_capture_unit_mini_1_0,linescanner_image_capture_unit_mini,{x_ipProduct=Vivado 2016.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=linescanner_image_capture_unit_mini,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module image_processing_2d_design_linescanner_image_capture_unit_mini_1_0 (
  enable,
  data,
  rst_cvc,
  rst_cds,
  sample,
  end_adc,
  lval,
  main_clock_source,
  main_clock,
  n_reset,
  pixel_data,
  pixel_captured
);

input wire enable;
input wire [7 : 0] data;
output wire rst_cvc;
output wire rst_cds;
output wire sample;
input wire end_adc;
input wire lval;
input wire main_clock_source;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 main_clock CLK" *)
output wire main_clock;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 n_reset RST" *)
input wire n_reset;
output wire [7 : 0] pixel_data;
output wire pixel_captured;

  linescanner_image_capture_unit_mini inst (
    .enable(enable),
    .data(data),
    .rst_cvc(rst_cvc),
    .rst_cds(rst_cds),
    .sample(sample),
    .end_adc(end_adc),
    .lval(lval),
    .main_clock_source(main_clock_source),
    .main_clock(main_clock),
    .n_reset(n_reset),
    .pixel_data(pixel_data),
    .pixel_captured(pixel_captured)
  );
endmodule
