`timescale 1 ns / 1 ps

module axi4_full_mod #
(
	parameter integer C_S_AXI_ID_WIDTH = 1,
	parameter integer C_S_AXI_DATA_WIDTH = 32,
	parameter integer C_S_AXI_ADDR_WIDTH = 6,
	parameter integer C_S_AXI_AWUSER_WIDTH = 0,
	parameter integer C_S_AXI_ARUSER_WIDTH = 0,
	parameter integer C_S_AXI_WUSER_WIDTH = 0,
	parameter integer C_S_AXI_RUSER_WIDTH = 0,
	parameter integer C_S_AXI_BUSER_WIDTH = 0,
	parameter integer MEMORY_SIZE = 64
)
(
	input wire s_axi_aclk,
	input wire s_axi_aresetn,
	input wire [C_S_AXI_ID_WIDTH-1:0] s_axi_awid,
	input wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
	input wire [7:0] s_axi_awlen,
	input wire [2:0] s_axi_awsize,
	input wire [1:0] s_axi_awburst,
	input wire s_axi_awlock,
	input wire [3:0] s_axi_awcache,
	input wire [2:0] s_axi_awprot,
	input wire [3:0] s_axi_awqos,
	input wire [3:0] s_axi_awregion,
	input wire [C_S_AXI_AWUSER_WIDTH-1:0] s_axi_awuser,
	input wire s_axi_awvalid,
	output wire s_axi_awready,
	input wire [C_S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
	input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
	input wire s_axi_wlast,
	input wire [C_S_AXI_WUSER_WIDTH-1:0] s_axi_wuser,
	input wire s_axi_wvalid,
	output wire s_axi_wready,
	output wire [C_S_AXI_ID_WIDTH-1:0] s_axi_bid,
	output wire [1:0] s_axi_bresp,
	output wire [C_S_AXI_BUSER_WIDTH-1:0] s_axi_buser,
	output wire s_axi_bvalid,
	input wire s_axi_bready,
	input wire [C_S_AXI_ID_WIDTH-1:0] s_axi_arid,
	input wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
	input wire [7:0] s_axi_arlen,
	input wire [2:0] s_axi_arsize,
	input wire [1:0] s_axi_arburst,
	input wire s_axi_arlock,
	input wire [3:0] s_axi_arcache,
	input wire [2:0] s_axi_arprot,
	input wire [3:0] s_axi_arqos,
	input wire [3:0] s_axi_arregion,
	input wire [C_S_AXI_ARUSER_WIDTH-1:0] s_axi_aruser,
	input wire s_axi_arvalid,
	output wire s_axi_arready,
	output wire [C_S_AXI_ID_WIDTH-1:0] s_axi_rid,
	output wire [C_S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
	output wire [1:0] s_axi_rresp,
	output wire s_axi_rlast,
	output wire [C_S_AXI_RUSER_WIDTH-1:0] s_axi_ruser,
	output wire s_axi_rvalid,
	input wire s_axi_rready
);

reg [C_S_AXI_ADDR_WIDTH-1:0] axi_awaddr;
reg axi_awready;
reg axi_wready;
reg [1:0] axi_bresp;
reg [C_S_AXI_BUSER_WIDTH-1:0] axi_buser;
reg axi_bvalid;
reg [C_S_AXI_ADDR_WIDTH-1:0] axi_araddr;
reg axi_arready;
reg [C_S_AXI_DATA_WIDTH-1:0] axi_rdata;
reg [1:0] axi_rresp;
reg axi_rlast;
reg [C_S_AXI_RUSER_WIDTH-1:0] axi_ruser;
reg axi_rvalid;

wire aw_wrap_en;
wire ar_wrap_en;
wire [31:0] aw_wrap_size;
wire [31:0] ar_wrap_size;
reg axi_awv_awr_flag;
reg axi_arv_arr_flag; 

reg [7:0] axi_awlen_cntr;
reg [7:0] axi_arlen_cntr;
reg [1:0] axi_arburst;
reg [1:0] axi_awburst;
reg [7:0] axi_arlen;
reg [7:0] axi_awlen;

localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32)+ 1;
localparam integer OPT_MEM_ADDR_BITS = 3;

wire [OPT_MEM_ADDR_BITS:0] memory_address;
reg [C_S_AXI_DATA_WIDTH-1:0] outgoing_data;

assign s_axi_awready = axi_awready;
assign s_axi_wready	= axi_wready;
assign s_axi_bresp = axi_bresp;
assign s_axi_buser = axi_buser;
assign s_axi_bvalid	= axi_bvalid;
assign s_axi_arready = axi_arready;
assign s_axi_rdata = axi_rdata;
assign s_axi_rresp = axi_rresp;
assign s_axi_rlast = axi_rlast;
assign s_axi_ruser = axi_ruser;
assign s_axi_rvalid	= axi_rvalid;
assign s_axi_bid = s_axi_awid;
assign s_axi_rid = s_axi_arid;
assign aw_wrap_size = (C_S_AXI_DATA_WIDTH/8 * (axi_awlen)); 
assign ar_wrap_size = (C_S_AXI_DATA_WIDTH/8 * (axi_arlen)); 
assign aw_wrap_en = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
assign ar_wrap_en = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;
assign s_axi_buser = 0;

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_awready <= 1'b0;
		axi_awv_awr_flag <= 1'b0;
	end
	
	else begin    
		if (~axi_awready && s_axi_awvalid && ~axi_awv_awr_flag && ~axi_arv_arr_flag) begin
			axi_awready <= 1'b1;
			axi_awv_awr_flag  <= 1'b1; 
		end
		
		else if (s_axi_wlast && axi_wready) begin
			axi_awv_awr_flag  <= 1'b0;
		end
		
		else begin
			axi_awready <= 1'b0;
		end
	end 
end       

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_awaddr <= 0;
		axi_awlen_cntr <= 0;
		axi_awburst <= 0;
		axi_awlen <= 0;
	end
	
	else begin
		if (~axi_awready && s_axi_awvalid && ~axi_awv_awr_flag) begin
			axi_awaddr <= s_axi_awaddr[C_S_AXI_ADDR_WIDTH-1:0];  
			axi_awburst <= s_axi_awburst; 
			axi_awlen <= s_axi_awlen;     
			axi_awlen_cntr <= 0;
		end
		
		else if((axi_awlen_cntr <= axi_awlen) && axi_wready && s_axi_wvalid) begin
			axi_awlen_cntr <= axi_awlen_cntr + 1;

			case (axi_awburst)
				2'b00: begin
					axi_awaddr <= axi_awaddr;          
				end
				
				2'b01: begin
					axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
					axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
				end
				
				2'b10:
					if (aw_wrap_en) begin
						axi_awaddr <= (axi_awaddr - aw_wrap_size); 
					end
					
					else begin
						axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
						axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}}; 
					end
					
				default: begin
					axi_awaddr <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
				end
			endcase              
		end
	end 
end       

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_wready <= 1'b0;
	end
	
	else begin    
		if (~axi_wready && s_axi_wvalid && axi_awv_awr_flag) begin
			axi_wready <= 1'b1;
		end
		//else if (~axi_awv_awr_flag)
		else if (s_axi_wlast && axi_wready) begin
			axi_wready <= 1'b0;
		end
	end 
end       

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_bvalid <= 0;
		axi_bresp <= 2'b0;
	end

	else begin    
		if (axi_awv_awr_flag && axi_wready && s_axi_wvalid && ~axi_bvalid && s_axi_wlast) begin
			axi_bvalid <= 1'b1;
			axi_bresp  <= 2'b0; 
		end
		
		else begin
			if (s_axi_bready && axi_bvalid) begin
				axi_bvalid <= 1'b0; 
			end  
		end
	end
 end   

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_arready <= 1'b0;
		axi_arv_arr_flag <= 1'b0;
	end
	
	else begin    
		if (~axi_arready && s_axi_arvalid && ~axi_awv_awr_flag && ~axi_arv_arr_flag) begin
			axi_arready <= 1'b1;
			axi_arv_arr_flag <= 1'b1;
		end
		
		else if (axi_rvalid && s_axi_rready && axi_arlen_cntr == axi_arlen) begin
			axi_arv_arr_flag  <= 1'b0;
		end

		else begin
			axi_arready <= 1'b0;
		end
	end 
end       

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
		axi_araddr <= 0;
		axi_arlen_cntr <= 0;
		axi_arburst <= 0;
		axi_arlen <= 0;
		axi_rlast <= 1'b0;
	end
	
	else begin    
		if (~axi_arready && s_axi_arvalid && ~axi_arv_arr_flag) begin
			axi_araddr <= s_axi_araddr[C_S_AXI_ADDR_WIDTH - 1:0]; 
			axi_arburst <= s_axi_arburst; 
			axi_arlen <= s_axi_arlen;     
			axi_arlen_cntr <= 0;
			axi_rlast <= 1'b0;
		end
		
		else if((axi_arlen_cntr <= axi_arlen) && axi_rvalid && s_axi_rready) begin
			axi_arlen_cntr <= axi_arlen_cntr + 1;
			axi_rlast <= 1'b0;
		
			case (axi_arburst)
				2'b00: begin
					axi_araddr <= axi_araddr;        
				end
				
				2'b01: begin
					axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1; 
					axi_araddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
				end
				
				2'b10:
					if (ar_wrap_en) begin
						axi_araddr <= (axi_araddr - ar_wrap_size); 
					end
					
					else begin
						axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1; 
						axi_araddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
					end
				default: begin
					axi_araddr <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB]+1;
				end
			endcase       
		end

		else if((axi_arlen_cntr == axi_arlen) && ~axi_rlast && axi_arv_arr_flag) begin
			axi_rlast <= 1'b1;
		end
		
		else if (s_axi_rready) begin
			axi_rlast <= 1'b0;
		end          
	end
end

always @(posedge s_axi_aclk) begin
	if (s_axi_aresetn == 1'b0) begin
	  axi_rvalid <= 0;
	  axi_rresp  <= 0;     
	end
	
	else begin    
		if (axi_arv_arr_flag && ~axi_rvalid) begin
			axi_rvalid <= 1'b1;
			axi_rresp  <= 2'b0;
		end
		
		else if (axi_rvalid && s_axi_rready) begin
			axi_rvalid <= 1'b0;
		end            
	end
end    

assign memory_address =
	(axi_arv_arr_flag ?
	axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] :
	(axi_awv_awr_flag? axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]:0));
	
wire memory_write_enable = axi_wready && s_axi_wvalid;
wire memory_read_enable = axi_arv_arr_flag; //& ~axi_rvalid

reg [8-1:0] memory [0:MEMORY_SIZE-1];

always @(posedge s_axi_aclk) begin
	if(memory_write_enable) begin
		if (s_axi_wstrb[0])
			memory[memory_address + 0] <= s_axi_wdata[(0*8+7) -: 8];
			
		if (s_axi_wstrb[1])
			memory[memory_address + 1] <= s_axi_wdata[(1*8+7) -: 8];
			
		if (s_axi_wstrb[2])
			memory[memory_address + 2] <= s_axi_wdata[(2*8+7) -: 8];
			
		if (s_axi_wstrb[3])
			memory[memory_address + 3] <= s_axi_wdata[(3*8+7) -: 8];
	end
end

always @(posedge s_axi_aclk) begin
	if (memory_read_enable) begin
		outgoing_data[(0*8+7) -: 8] <= memory[memory_address + 0];
		outgoing_data[(1*8+7) -: 8] <= memory[memory_address + 1];
		outgoing_data[(2*8+7) -: 8] <= memory[memory_address + 2];
		outgoing_data[(3*8+7) -: 8] <= memory[memory_address + 3];
	end
end

always @(outgoing_data, axi_rvalid) begin
	if (axi_rvalid) begin
		axi_rdata <= outgoing_data;
	end
	
	else begin
		axi_rdata <= 32'h00000000;
	end       
end    

endmodule
