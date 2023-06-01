
`include "scr1_memif.svh"
`include "scr1_arch_description.svh"

module scr1_accel
(
    // Control signals
    input   logic                           clk,
    input   logic                           rst_n,


    // Core data interface
    output  logic                           dmem_req_ack,
    input   logic                           dmem_req,
    input   type_scr1_mem_cmd_e             dmem_cmd,
    input   type_scr1_mem_width_e           dmem_width,
    input   logic [`SCR1_DMEM_AWIDTH-1:0]   dmem_addr,
    input   logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_wdata,
    output  logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_rdata,
    output  type_scr1_mem_resp_e            dmem_resp
);

//-------------------------------------------------------------------------------
// Local signal declaration
//-------------------------------------------------------------------------------
logic                               dmem_req_en;
logic                               dmem_rd;
logic                               dmem_wr;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_writedata;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_rdata_local;
logic [1:0]                         dmem_rdata_shift_reg;
//-------------------------------------------------------------------------------
// Core interface
//-------------------------------------------------------------------------------
assign dmem_req_en = (dmem_resp == SCR1_MEM_RESP_RDY_OK) ^ dmem_req;


always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        dmem_resp <= SCR1_MEM_RESP_NOTRDY;
    end else if (dmem_req_en) begin
        dmem_resp <= dmem_req ? SCR1_MEM_RESP_RDY_OK : SCR1_MEM_RESP_NOTRDY;
    end
end

assign dmem_req_ack = 1'b1;
//-------------------------------------------------------------------------------
// Memory data composing
//-------------------------------------------------------------------------------
assign dmem_rd  = dmem_req & (dmem_cmd == SCR1_MEM_CMD_RD);
assign dmem_wr  = dmem_req & (dmem_cmd == SCR1_MEM_CMD_WR);

always_comb begin
    dmem_writedata = dmem_wdata;
    case ( dmem_width )
        SCR1_MEM_WIDTH_BYTE : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH /  8){dmem_wdata[7:0]}};
        end
        SCR1_MEM_WIDTH_HWORD : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH / 16){dmem_wdata[15:0]}};
        end
        default : begin
        end
    endcase
end

 
	 reg go_bit;
	 wire go_bit_in;
	 reg done_bit;
	 wire done_bit_in;
	 reg [15:0] counter;
	 reg [31:0] data_A;
	 reg [31:0] data_B;
	 wire [31:0] data_C;
	 reg [31:0] result;
	 reg [7:0] in1, in2;
	 wire[7:0] out;

	 // SHA256Init Registers
	 reg [31:0] state0;
	 reg [31:0] state1;
	 reg [31:0] state2;
	 reg [31:0] state3;
	 reg [31:0] state4;
	 reg [31:0] state5;
	 reg [31:0] state6;
	 reg [31:0] state7;

	 //data registers
	 reg [31:0] D0;
	 reg [31:0] D1;
	 reg [31:0] D2;
	 reg [31:0] D3;
	 reg [31:0] D4;
	 reg [31:0] D5;
	 reg [31:0] D6;
	 reg [31:0] D7; 
	 reg [31:0] D8; 
	 reg [31:0] D9;
	 reg [31:0] D10;
	 reg [31:0] D11;
	 reg [31:0] D12;
	 reg [31:0] D13;
	 reg [31:0] D14;
	 reg [31:0] D15;


	
	 //word register
	 reg [31:0] k[63:0];
	 
	 // SHA256Init hardware initilize
	 always@(posedge clk or negedge rst_n) begin
		//if reset button is pressed then initilize the registers, maybe add a go button for later
		if(!rst_n) begin
			state0 <= 32'h0x6a09e667;
			state1 <= 32'h0xbb67ae85;
			state2 <= 32'h0x3c6ef372;
			state3 <= 32'h0xa54ff53a;
			state4 <= 32'h0x510e527f;
			state5 <= 32'h0x9b05688c;
			state6 <= 32'h0x1f83d9ab;
			state7 <= 32'h0x5be0cd19;
//			k[0] <= 32'h0x428a2f98;
//			k[1] <= 32'h0x71374491;
//			k[2] <= 32'h0xb5c0fbcf;
//			k[3] <= 32'h0xe9b5dba5;
//			k[4] <= 32'h0x3956c25b;
//			k[5] <= 32'h0x59f111f1;
//			k[6] <= 32'h0x923f82a4;
//			k[7] <= 32'h0xab1c5ed5;
//			k[8] <= 32'h0xd807aa98;
//			k[9] <= 32'h0x12835b01;
//			k[10] <= 32'h0x243185be;
//			k[11] <= 32'h0x550c7dc3;
//			k[12] <= 32'h0x72be5d74;
//			k[13] <= 32'h0x80deb1fe;
//			k[14] <= 32'h0x9bdc06a7;
//			k[15] <= 32'h0xc19bf174;
//			k[16] <= 32'h0xe49b69c1;
//			k[17] <= 32'h0xefbe4786;
//			k[18] <= 32'h0x0fc19dc6;
//			k[19] <= 32'h0x240ca1cc;
//			k[20] <= 32'h0x2de92c6f;
//			k[21] <= 32'h0x4a7484aa;
//			k[22] <= 32'h0x5cb0a9dc;
//			k[23] <= 32'h0x76f988da;
//			k[24] <= 32'h0x983e5152;
//			k[25] <= 32'h0xa831c66d;
//			k[26] <= 32'h0xb00327c8;
//			k[27] <= 32'h0xbf597fc7;
//			k[28] <= 32'h0xc6e00bf3;
//			k[29] <= 32'h0xd5a79147;
//			k[30] <= 32'h0x06ca6351;
//			k[31] <= 32'h0x14292967;
//			k[32] <= 32'h0x27b70a85;
//			k[33] <= 32'h0x2e1b2138;
//			k[34] <= 32'h0x4d2c6dfc;
//			k[35] <= 32'h0x53380d13;
//			k[36] <= 32'h0x650a7354;
//			k[37] <= 32'h0x766a0abb;
//			k[38] <= 32'h0x81c2c92e;
//			k[39] <= 32'h0x92722c85;
//			k[40] <= 32'h0xa2bfe8a1;
//			k[41] <= 32'h0xa81a664b;
//			k[42] <= 32'h0xc24b8b70;
//			k[43] <= 32'h0xc76c51a3;
//			k[44] <= 32'h0xd192e819;
//			k[45] <= 32'h0xd6990624;
//			k[46] <= 32'h0xf40e3585;
//			k[47] <= 32'h0x106aa070;
//			k[48] <= 32'h0x19a4c116;
//			k[49] <= 32'h0x1e376c08;
//			k[50] <= 32'h0x2748774c;
//			k[51] <= 32'h0x34b0bcb5;
//			k[52] <= 32'h0x391c0cb3;
//			k[53] <= 32'h0x4ed8aa4a;
//			k[54] <= 32'h0x5b9cca4f;
//			k[55] <= 32'h0x682e6ff3;
//			k[56] <= 32'h0x748f82ee;
//			k[57] <= 32'h0x78a5636f;
//			k[58] <= 32'h0x84c87814;
//			k[59] <= 32'h0x8cc70208;
//			k[60] <= 32'h0x90befffa;
//			k[61] <= 32'h0xa4506ceb;
//			k[62] <= 32'h0xbef9a3f7;
//			k[63] <= 32'h0xc67178f2;

		end
		
		else begin
			if (dmem_wr) begin
				//write to states, maybe also data
				state0 <= (dmem_addr[8:2] == 7'b0000101) ? dmem_writedata : state0;
				state1 <= (dmem_addr[8:2] == 7'b0000110) ? dmem_writedata : state1;
				state2 <= (dmem_addr[8:2] == 7'b0001000) ? dmem_writedata : state2;
				state3 <= (dmem_addr[8:2] == 7'b0001001) ? dmem_writedata : state3;
				state4 <= (dmem_addr[8:2] == 7'b0001010) ? dmem_writedata : state4;
				state5 <= (dmem_addr[8:2] == 7'b0001011) ? dmem_writedata : state5;				
				state6 <= (dmem_addr[8:2] == 7'b0001100) ? dmem_writedata : state6;
				state7 <= (dmem_addr[8:2] == 7'b0001101) ? dmem_writedata : state7;
			end
//			else begin
//				state0 <= state0;
//				state1 <= state1;
//				state2 <= state2;
//				state3 <= state3;
//				state4 <= state4;
//				state5 <= state5;
//				state6 <= state6;
//				state7 <= state7;
		end	
	 end

	 assign ctr = counter;
	 
	 //read register
	 always @(dmem_addr[8:2], data_A, data_B, data_C, counter, done_bit, go_bit, counter,state0,state1,state2,state3,state4,state5,state6,state7,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15) begin
		case(dmem_addr[8:2])
		7'b0000000: dmem_rdata_local = {done_bit, 30'b0, go_bit};
		7'b0000001: dmem_rdata_local = {16'b0, counter}; 
		7'b0000010: dmem_rdata_local = data_A;
		7'b0000011: dmem_rdata_local = data_B;
		7'b0000100: dmem_rdata_local = data_C;
		//new registers allocation
		//state registers
		7'b0000101: dmem_rdata_local = state0;
		7'b0000110: dmem_rdata_local = state1;
		7'b0000111: dmem_rdata_local = state2;
		7'b0001000: dmem_rdata_local = state3;
		7'b0001001: dmem_rdata_local = state4;
		7'b0001010: dmem_rdata_local = state5;
		7'b0001011: dmem_rdata_local = state6;
		7'b0001100: dmem_rdata_local = state7;
		//data registers
		7'b0001101: dmem_rdata_local = D0;
		7'b0001110: dmem_rdata_local = D1;
		7'b0001111: dmem_rdata_local = D2;
		7'b0010000: dmem_rdata_local = D3;
		7'b0010001: dmem_rdata_local = D4;
		7'b0010010: dmem_rdata_local = D5;
		7'b0010011: dmem_rdata_local = D6;
		7'b0010100: dmem_rdata_local = D7;
		7'b0010101: dmem_rdata_local = D8;
		7'b0010110: dmem_rdata_local = D9;
		7'b0010111: dmem_rdata_local = D10;
		7'b0011000: dmem_rdata_local = D11;
		7'b0011001: dmem_rdata_local = D12;
		7'b0011010: dmem_rdata_local = D13;
		7'b0011011: dmem_rdata_local = D14;
		7'b0011100: dmem_rdata_local = D15;

		//k words
		//7'b0010101: dmem_rdata_local = k[0];
		
		default: dmem_rdata_local = 32'b0;
		endcase
	 end
	 
	 assign go_bit_in = (dmem_wr & (dmem_addr[8:2] == 7'b0000000));
	
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) go_bit <= 1'b0;
		else go_bit <=  go_bit_in ? 1'b1 : 1'b0;
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) begin
			counter <=16'b0;
			data_A <= 32'b0;
			data_B <= 32'b0;
		end
		else begin
			if (dmem_wr) begin
				data_A <= (dmem_addr[8:2] == 7'b0000010) ? dmem_writedata : data_A;
				data_B <= (dmem_addr[8:2] == 7'b0000011) ? dmem_writedata : data_B;
			end
			else begin
				data_A <= data_A;
				data_B <= data_B;
	//			state0 <= state0;
	//			state1 <= state1;
	//			state2 <= state2;
	//			state3 <= state3;
	//			state4 <= state4;
	//			state5 <= state5;
	//			state6 <= state6;
	//			state7 <= state7;
			end
			counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter +16'h01;
		end
		
	 		//expanded the input to 32 bit.
	 always @(data_A, counter) begin
		case(counter)
		16'b0: 	in1 = data_A[7:0];
		16'b1:	in1 = data_A[15:8];
		16'b10: 	in1 = data_A[23:16];
		16'b11:	in1 = data_A[31:24];
		default: in1 = data_A[7:0];
		endcase
	 end
			//expanded the input to 32 bit.
	  always @(data_B, counter) begin
		case(counter)
		16'b00: 	in2 = data_B[7:0];
		16'b01:	in2 = data_B[15:8];
		16'b10: 	in2 = data_B[23:16];
		16'b11:	in2 = data_B[31:24];
		default: in2 = data_B[7:0];
		endcase
	 end
	 
	 
	 assign out = in1 * in2;
	 
	wire [31:0] result_in;
					
					//expanded the result wire to have 32 bit result.
	assign result_in = (counter==16'd0) ? {result[31:8], out} : 
							(counter==16'd1) ? {result[31:16], out, result[7:0]}:
							(counter==16'd2) ? {result[31:24], out, result[15:0]}:
							(counter==16'd3) ? { out, result[23:0]}:
							 result;
							 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) result <=32'h0;
		else result <= result_in;
	 	 
	 assign data_C = result;
	 
	 //the counter has 4 cycles.
	 assign done_bit_in = (counter == 16'd4);
	 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;
	 

always_ff @(posedge clk) begin
    if (dmem_rd) begin
        dmem_rdata_shift_reg <= dmem_addr[1:0];
    end
end

assign dmem_rdata = dmem_rdata_local >> ( 8 * dmem_rdata_shift_reg );

endmodule : scr1_accel