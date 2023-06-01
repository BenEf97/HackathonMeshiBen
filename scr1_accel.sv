
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

//m registers
	reg [31:0] m0;
	reg [31:0] m1;
	reg [31:0] m2;
	reg [31:0] m3;
	reg [31:0] m4;
	reg [31:0] m5;
	reg [31:0] m6;
	reg [31:0] m7;
	reg [31:0] m8;
	reg [31:0] m9;
	reg [31:0] m10;
	reg [31:0] m11;
	reg [31:0] m12;
	reg [31:0] m13;
	reg [31:0] m14;
	reg [31:0] m15;
	reg [31:0] m16;
	reg [31:0] m17;
	reg [31:0] m18;
	reg [31:0] m19;
	reg [31:0] m20;
	reg [31:0] m21;
	reg [31:0] m22;
	reg [31:0] m23;
	reg [31:0] m24;
	reg [31:0] m25;
	reg [31:0] m26;
	reg [31:0] m27;
	reg [31:0] m28;
	reg [31:0] m29;
	reg [31:0] m30;
	reg [31:0] m31;
	reg [31:0] m32;
	reg [31:0] m33;
	reg [31:0] m34;
	reg [31:0] m35;
	reg [31:0] m36;
	reg [31:0] m37;
	reg [31:0] m38;
	reg [31:0] m39;
	reg [31:0] m40;
	reg [31:0] m41;
	reg [31:0] m42;
	reg [31:0] m43;
	reg [31:0] m44;
	reg [31:0] m45;
	reg [31:0] m46;
	reg [31:0] m47;
	reg [31:0] m48;
	reg [31:0] m49;
	reg [31:0] m50;
	reg [31:0] m51;
	reg [31:0] m52;
	reg [31:0] m53;
	reg [31:0] m54;
	reg [31:0] m55;
	reg [31:0] m56;
	reg [31:0] m57;
	reg [31:0] m58;
	reg [31:0] m59;
	reg [31:0] m60;
	reg [31:0] m61;
	reg [31:0] m62;
	reg [31:0] m63;
	
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

				D0 <= (dmem_addr[8:2] == 7'b0001101) ? dmem_writedata : D0;
				D1 <= (dmem_addr[8:2] == 7'b0001110) ? dmem_writedata : D1;
				D2 <= (dmem_addr[8:2] == 7'b0001111) ? dmem_writedata : D2;
				D3 <= (dmem_addr[8:2] == 7'b0010000) ? dmem_writedata : D3;
				D4 <= (dmem_addr[8:2] == 7'b0010001) ? dmem_writedata : D4;
				D5 <= (dmem_addr[8:2] == 7'b0010010) ? dmem_writedata : D5;
				D6 <= (dmem_addr[8:2] == 7'b0010011) ? dmem_writedata : D6;
				D7 <= (dmem_addr[8:2] == 7'b0010100) ? dmem_writedata : D7;
				D8 <= (dmem_addr[8:2] == 7'b0010101) ? dmem_writedata : D8;
				D9 <= (dmem_addr[8:2] == 7'b0010110) ? dmem_writedata : D9;
				D10 <= (dmem_addr[8:2] == 7'b0010111) ? dmem_writedata : D10;
				D11 <= (dmem_addr[8:2] == 7'b0011000) ? dmem_writedata : D11;
				D12 <= (dmem_addr[8:2] == 7'b0011001) ? dmem_writedata : D12;
				D13 <= (dmem_addr[8:2] == 7'b0011010) ? dmem_writedata : D13;
				D14 <= (dmem_addr[8:2] == 7'b0011011) ? dmem_writedata : D14;
				D15 <= (dmem_addr[8:2] == 7'b0011100) ? dmem_writedata : D15;
				
				m0 <= (dmem_addr[8:2] == 7'b0011101) ? dmem_writedata : m0;
				m1 <= (dmem_addr[8:2] == 7'b0011110) ? dmem_writedata : m1;
				m2 <= (dmem_addr[8:2] == 7'b0011111) ? dmem_writedata : m2;
				m3 <= (dmem_addr[8:2] == 7'b0100000) ? dmem_writedata : m3;
				m4 <= (dmem_addr[8:2] == 7'b0100001) ? dmem_writedata : m4;
				m5 <= (dmem_addr[8:2] == 7'b0100010) ? dmem_writedata : m5;
				m6 <= (dmem_addr[8:2] == 7'b0100011) ? dmem_writedata : m6;
				m7 <= (dmem_addr[8:2] == 7'b0100100) ? dmem_writedata : m7;
				m8 <= (dmem_addr[8:2] == 7'b0100101) ? dmem_writedata : m8;
				m9 <= (dmem_addr[8:2] == 7'b0100110) ? dmem_writedata : m9;
				m10 <= (dmem_addr[8:2] == 7'b0100111) ? dmem_writedata : m10;
				m11 <= (dmem_addr[8:2] == 7'b0101000) ? dmem_writedata : m11;
				m12 <= (dmem_addr[8:2] == 7'b0101001) ? dmem_writedata : m12;
				m13 <= (dmem_addr[8:2] == 7'b0101010) ? dmem_writedata : m13;
				m14 <= (dmem_addr[8:2] == 7'b0101011) ? dmem_writedata : m14;
				m15 <= (dmem_addr[8:2] == 7'b0101100) ? dmem_writedata : m15;
				m16 <= (dmem_addr[8:2] == 7'b0101101) ? dmem_writedata : m16;
				m17 <= (dmem_addr[8:2] == 7'b0101110) ? dmem_writedata : m17;
				m18 <= (dmem_addr[8:2] == 7'b0101111) ? dmem_writedata : m18;
				m19 <= (dmem_addr[8:2] == 7'b0110000) ? dmem_writedata : m19;
				m20 <= (dmem_addr[8:2] == 7'b0110001) ? dmem_writedata : m20;
				m21 <= (dmem_addr[8:2] == 7'b0110010) ? dmem_writedata : m21;
				m22 <= (dmem_addr[8:2] == 7'b0110011) ? dmem_writedata : m22;
				m23 <= (dmem_addr[8:2] == 7'b0110100) ? dmem_writedata : m23;
				m24 <= (dmem_addr[8:2] == 7'b0110101) ? dmem_writedata : m24;
				m25 <= (dmem_addr[8:2] == 7'b0110110) ? dmem_writedata : m25;
				m26 <= (dmem_addr[8:2] == 7'b0110111) ? dmem_writedata : m26;
				m27 <= (dmem_addr[8:2] == 7'b0111000) ? dmem_writedata : m27;
				m28 <= (dmem_addr[8:2] == 7'b0111001) ? dmem_writedata : m28;
				m29 <= (dmem_addr[8:2] == 7'b0111010) ? dmem_writedata : m29;
				m30 <= (dmem_addr[8:2] == 7'b0111011) ? dmem_writedata : m30;
				m31 <= (dmem_addr[8:2] == 7'b0111100) ? dmem_writedata : m31;
				m32 <= (dmem_addr[8:2] == 7'b0111101) ? dmem_writedata : m32;
				m33 <= (dmem_addr[8:2] == 7'b0111110) ? dmem_writedata : m33;
				m34 <= (dmem_addr[8:2] == 7'b0111111) ? dmem_writedata : m34;
				m35 <= (dmem_addr[8:2] == 7'b1000000) ? dmem_writedata : m35;
				m36 <= (dmem_addr[8:2] == 7'b1000001) ? dmem_writedata : m36;
				m37 <= (dmem_addr[8:2] == 7'b1000010) ? dmem_writedata : m37;
				m38 <= (dmem_addr[8:2] == 7'b1000011) ? dmem_writedata : m38;
				m39 <= (dmem_addr[8:2] == 7'b1000100) ? dmem_writedata : m39;
				m40 <= (dmem_addr[8:2] == 7'b1000101) ? dmem_writedata : m40;
				m41 <= (dmem_addr[8:2] == 7'b1000110) ? dmem_writedata : m41;
				m42 <= (dmem_addr[8:2] == 7'b1000111) ? dmem_writedata : m42;
				m43 <= (dmem_addr[8:2] == 7'b1001000) ? dmem_writedata : m43;
				m44 <= (dmem_addr[8:2] == 7'b1001001) ? dmem_writedata : m44;
				m45 <= (dmem_addr[8:2] == 7'b1001010) ? dmem_writedata : m45;
				m46 <= (dmem_addr[8:2] == 7'b1001011) ? dmem_writedata : m46;
				m47 <= (dmem_addr[8:2] == 7'b1001100) ? dmem_writedata : m47;
				m48 <= (dmem_addr[8:2] == 7'b1001101) ? dmem_writedata : m48;
				m49 <= (dmem_addr[8:2] == 7'b1001110) ? dmem_writedata : m49;
				m50 <= (dmem_addr[8:2] == 7'b1001111) ? dmem_writedata : m50;
				m51 <= (dmem_addr[8:2] == 7'b1010000) ? dmem_writedata : m51;
				m52 <= (dmem_addr[8:2] == 7'b1010001) ? dmem_writedata : m52;
				m53 <= (dmem_addr[8:2] == 7'b1010010) ? dmem_writedata : m53;
				m54 <= (dmem_addr[8:2] == 7'b1010011) ? dmem_writedata : m54;
				m55 <= (dmem_addr[8:2] == 7'b1010100) ? dmem_writedata : m55;
				m56 <= (dmem_addr[8:2] == 7'b1010101) ? dmem_writedata : m56;
				m57 <= (dmem_addr[8:2] == 7'b1010110) ? dmem_writedata : m57;
				m58 <= (dmem_addr[8:2] == 7'b1010111) ? dmem_writedata : m58;
				m59 <= (dmem_addr[8:2] == 7'b1011000) ? dmem_writedata : m59;
				m60 <= (dmem_addr[8:2] == 7'b1011001) ? dmem_writedata : m60;
				m61 <= (dmem_addr[8:2] == 7'b1011010) ? dmem_writedata : m61;
				m62 <= (dmem_addr[8:2] == 7'b1011011) ? dmem_writedata : m62;
				m63 <= (dmem_addr[8:2] == 7'b1011100) ? dmem_writedata : m63;
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
	 //dmem_addr[8:2], data_A, data_B, data_C, counter, done_bit, go_bit, counter,state0,state1,state2,state3,state4,state5,state6,state7,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15
	 always @(*) begin
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

		//m registers
		7'b0011101: dmem_rdata_local = m0;
		7'b0011110: dmem_rdata_local = m1;
		7'b0011111: dmem_rdata_local = m2;
		7'b0100000: dmem_rdata_local = m3;
		7'b0100001: dmem_rdata_local = m4;
		7'b0100010: dmem_rdata_local = m5;
		7'b0100011: dmem_rdata_local = m6;
		7'b0100100: dmem_rdata_local = m7;
		7'b0100101: dmem_rdata_local = m8;
		7'b0100110: dmem_rdata_local = m9;
		7'b0100111: dmem_rdata_local = m10;
		7'b0101000: dmem_rdata_local = m11;
		7'b0101001: dmem_rdata_local = m12;
		7'b0101010: dmem_rdata_local = m13;
		7'b0101011: dmem_rdata_local = m14;
		7'b0101100: dmem_rdata_local = m15;
		7'b0101101: dmem_rdata_local = m16;
		7'b0101110: dmem_rdata_local = m17;
		7'b0101111: dmem_rdata_local = m18;
		7'b0110000: dmem_rdata_local = m19;
		7'b0110001: dmem_rdata_local = m20;
		7'b0110010: dmem_rdata_local = m21;
		7'b0110011: dmem_rdata_local = m22;
		7'b0110100: dmem_rdata_local = m23;
		7'b0110101: dmem_rdata_local = m24;
		7'b0110110: dmem_rdata_local = m25;
		7'b0110111: dmem_rdata_local = m26;
		7'b0111000: dmem_rdata_local = m27;
		7'b0111001: dmem_rdata_local = m28;
		7'b0111010: dmem_rdata_local = m29;
		7'b0111011: dmem_rdata_local = m30;
		7'b0111100: dmem_rdata_local = m31;
		7'b0111101: dmem_rdata_local = m32;
		7'b0111110: dmem_rdata_local = m33;
		7'b0111111: dmem_rdata_local = m34;
		7'b1000000: dmem_rdata_local = m35;
		7'b1000001: dmem_rdata_local = m36;
		7'b1000010: dmem_rdata_local = m37;
		7'b1000011: dmem_rdata_local = m38;
		7'b1000100: dmem_rdata_local = m39;
		7'b1000101: dmem_rdata_local = m40;
		7'b1000110: dmem_rdata_local = m41;
		7'b1000111: dmem_rdata_local = m42;
		7'b1001000: dmem_rdata_local = m43;
		7'b1001001: dmem_rdata_local = m44;
		7'b1001010: dmem_rdata_local = m45;
		7'b1001011: dmem_rdata_local = m46;
		7'b1001100: dmem_rdata_local = m47;
		7'b1001101: dmem_rdata_local = m48;
		7'b1001110: dmem_rdata_local = m49;
		7'b1001111: dmem_rdata_local = m50;
		7'b1010000: dmem_rdata_local = m51;
		7'b1010001: dmem_rdata_local = m52;
		7'b1010010: dmem_rdata_local = m53;
		7'b1010011: dmem_rdata_local = m54;
		7'b1010100: dmem_rdata_local = m55;
		7'b1010101: dmem_rdata_local = m56;
		7'b1010110: dmem_rdata_local = m57;
		7'b1010111: dmem_rdata_local = m58;
		7'b1011000: dmem_rdata_local = m59;
		7'b1011001: dmem_rdata_local = m60;
		7'b1011010: dmem_rdata_local = m61;
		7'b1011011: dmem_rdata_local = m62;
		7'b1011100: dmem_rdata_local = m63;//92

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