
`include "scr1_memif.svh"
`include "scr1_arch_description.svh"
`define SIG0(x) (`ROTRIGHT(x, 7) ^ `ROTRIGHT(x, 18) ^ ((x) >> 3))
`define SIG1(x) (`ROTRIGHT(x, 17) ^ `ROTRIGHT(x, 19) ^ ((x) >> 10))
`define ROTLEFT(a, b) (((a) << (b)) | ((a) >> (32 - (b))))
`define ROTRIGHT(a, b) (((a) >> (b)) | ((a) << (32 - (b))))

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

	 reg [15:0] cnt;

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

	//rest of SHA256_CTX structure
	reg [31:0] DataLen;
	reg [31:0] BitLen0;
	reg [31:0] BitLen1;

	
	 //word register
	 //reg [31:0] k[63:0];
	 
	 // SHA256Init hardware initilize
	 always@(posedge clk or negedge rst_n) begin
		//if reset button is pressed then initilize the registers, maybe add a go button for later
		if(!rst_n) begin
			state0 <= 32'h6a09e667;
			state1 <= 32'hbb67ae85;
			state2 <= 32'h3c6ef372;
			state3 <= 32'ha54ff53a;
			state4 <= 32'h510e527f;
			state5 <= 32'h9b05688c;
			state6 <= 32'h1f83d9ab;
			state7 <= 32'h5be0cd19;

			// k[0] <= 32'h428a2f98;
			// k[1] <= 32'h71374491;
			// k[2] <= 32'hb5c0fbcf;
			// k[3] <= 32'he9b5dba5;
			// k[4] <= 32'h3956c25b;
			// k[5] <= 32'h0x59f111f1;
			// k[6] <= 32'h0x923f82a4;
			// k[7] <= 32'h0xab1c5ed5;
			// k[8] <= 32'h0xd807aa98;
			// k[9] <= 32'h0x12835b01;
			// k[10] <= 32'h0x243185be;
			// k[11] <= 32'h0x550c7dc3;
			// k[12] <= 32'h0x72be5d74;
			// k[13] <= 32'h0x80deb1fe;
			// k[14] <= 32'h0x9bdc06a7;
			// k[15] <= 32'h0xc19bf174;
			// k[16] <= 32'h0xe49b69c1;
			// k[17] <= 32'h0xefbe4786;
			// k[18] <= 32'h0x0fc19dc6;
			// k[19] <= 32'h0x240ca1cc;
			// k[20] <= 32'h0x2de92c6f;
			// k[21] <= 32'h0x4a7484aa;
			// k[22] <= 32'h0x5cb0a9dc;
			// k[23] <= 32'h0x76f988da;
			// k[24] <= 32'h0x983e5152;
			// k[25] <= 32'h0xa831c66d;
			// k[26] <= 32'h0xb00327c8;
			// k[27] <= 32'h0xbf597fc7;
			// k[28] <= 32'h0xc6e00bf3;
			// k[29] <= 32'h0xd5a79147;
			// k[30] <= 32'h0x06ca6351;
			// k[31] <= 32'h0x14292967;
			// k[32] <= 32'h0x27b70a85;
			// k[33] <= 32'h0x2e1b2138;
			// k[34] <= 32'h0x4d2c6dfc;
			// k[35] <= 32'h0x53380d13;
			// k[36] <= 32'h0x650a7354;
			// k[37] <= 32'h0x766a0abb;
			// k[38] <= 32'h0x81c2c92e;
			// k[39] <= 32'h0x92722c85;
			// k[40] <= 32'h0xa2bfe8a1;
			// k[41] <= 32'h0xa81a664b;
			// k[42] <= 32'h0xc24b8b70;
			// k[43] <= 32'h0xc76c51a3;
			// k[44] <= 32'h0xd192e819;
			// k[45] <= 32'h0xd6990624;
			// k[46] <= 32'h0xf40e3585;
			// k[47] <= 32'h0x106aa070;
			// k[48] <= 32'h0x19a4c116;
			// k[49] <= 32'h0x1e376c08;
			// k[50] <= 32'h0x2748774c;
			// k[51] <= 32'h0x34b0bcb5;
			// k[52] <= 32'h0x391c0cb3;
			// k[53] <= 32'h0x4ed8aa4a;
			// k[54] <= 32'h0x5b9cca4f;
			// k[55] <= 32'h0x682e6ff3;
			// k[56] <= 32'h0x748f82ee;
			// k[57] <= 32'h0x78a5636f;
			// k[58] <= 32'h0x84c87814;
			// k[59] <= 32'h0x8cc70208;
			// k[60] <= 32'h0x90befffa;
			// k[61] <= 32'h0xa4506ceb;
			// k[62] <= 32'h0xbef9a3f7;
			// k[63] <= 32'h0xc67178f2;

		
	 
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

				DataLen <= (dmem_addr[8:2] == 7'b1011101) ? dmem_writedata : DataLen;
				BitLen0 <= (dmem_addr[8:2] == 7'b1011110) ? dmem_writedata : BitLen0;
				BitLen1 <= (dmem_addr[8:2] == 7'b1011111) ? dmem_writedata : BitLen1;

				// k0 <= (dmem_addr[8:2] == 7'b1011101) ? dmem_writedata : k0;
				// k1 <= (dmem_addr[8:2] == 7'b1011110) ? dmem_writedata : k1;
				// k2 <= (dmem_addr[8:2] == 7'b1011111) ? dmem_writedata : k2;
				// k3 <= (dmem_addr[8:2] == 7'b1100000) ? dmem_writedata : k3;
				// k4 <= (dmem_addr[8:2] == 7'b1100001) ? dmem_writedata : k4;
				// k5 <= (dmem_addr[8:2] == 7'b1100010) ? dmem_writedata : k5;
				// k6 <= (dmem_addr[8:2] == 7'b1100011) ? dmem_writedata : k6;
				// k7 <= (dmem_addr[8:2] == 7'b1100100) ? dmem_writedata : k7;
				// k8 <= (dmem_addr[8:2] == 7'b1100101) ? dmem_writedata : k8;
				// k9 <= (dmem_addr[8:2] == 7'b1100110) ? dmem_writedata : k9;
				// k10 <= (dmem_addr[8:2] == 7'b1100111) ? dmem_writedata : k10;
				// k11 <= (dmem_addr[8:2] == 7'b1101000) ? dmem_writedata : k11;
				// k12 <= (dmem_addr[8:2] == 7'b1101001) ? dmem_writedata : k12;
				// k13 <= (dmem_addr[8:2] == 7'b1101010) ? dmem_writedata : k13;
				// k14 <= (dmem_addr[8:2] == 7'b1101011) ? dmem_writedata : k14;
				// k15 <= (dmem_addr[8:2] == 7'b1101100) ? dmem_writedata : k15;
				// k16 <= (dmem_addr[8:2] == 7'b1101101) ? dmem_writedata : k16;
				// k17 <= (dmem_addr[8:2] == 7'b1101110) ? dmem_writedata : k17;
				// k18 <= (dmem_addr[8:2] == 7'b1101111) ? dmem_writedata : k18;
				// k19 <= (dmem_addr[8:2] == 7'b1110000) ? dmem_writedata : k19;
				// k20 <= (dmem_addr[8:2] == 7'b1110001) ? dmem_writedata : k20;
				// k21 <= (dmem_addr[8:2] == 7'b1110010) ? dmem_writedata : k21;
				// k22 <= (dmem_addr[8:2] == 7'b1110011) ? dmem_writedata : k22;
				// k23 <= (dmem_addr[8:2] == 7'b1110100) ? dmem_writedata : k23;
				// k24 <= (dmem_addr[8:2] == 7'b1110100) ? dmem_writedata : k24;
				// k25 <= (dmem_addr[8:2] == 7'b1110101) ? dmem_writedata : k25;
				// k26 <= (dmem_addr[8:2] == 7'b1110110) ? dmem_writedata : k26;
				// k27 <= (dmem_addr[8:2] == 7'b1110111) ? dmem_writedata : k27;
				// k28 <= (dmem_addr[8:2] == 7'b1111000) ? dmem_writedata : k28;
				// k29 <= (dmem_addr[8:2] == 7'b1111001) ? dmem_writedata : k29;
				// k30 <= (dmem_addr[8:2] == 7'b1111010) ? dmem_writedata : k30;
				// k31 <= (dmem_addr[8:2] == 7'b1111011) ? dmem_writedata : k31;
				// k32 <= (dmem_addr[8:2] == 7'b1111100) ? dmem_writedata : k32;
				// k33 <= (dmem_addr[8:2] == 7'b1111101) ? dmem_writedata : k33;
				// k34 <= (dmem_addr[8:2] == 7'b1111110) ? dmem_writedata : k34;
				// k35 <= (dmem_addr[8:2] == 7'b1111111) ? dmem_writedata : k35;
				// k36 <= (dmem_addr[8:2] == 8'b10000000) ? dmem_writedata : k36;
				// k37 <= (dmem_addr[8:2] == 8'b10000001) ? dmem_writedata : k37;
				// k38 <= (dmem_addr[8:2] == 8'b10000010) ? dmem_writedata : k38;
				// k39 <= (dmem_addr[8:2] == 8'b10000011) ? dmem_writedata : k39;
				// k40 <= (dmem_addr[8:2] == 8'b10000100) ? dmem_writedata : k40;
				// k41 <= (dmem_addr[8:2] == 8'b10000101) ? dmem_writedata : k41;
				// k42 <= (dmem_addr[8:2] == 8'b10000110) ? dmem_writedata : k42;
				// k43 <= (dmem_addr[8:2] == 8'b10000111) ? dmem_writedata : k43;
				// k44 <= (dmem_addr[8:2] == 8'b10001000) ? dmem_writedata : k44;
				// k45 <= (dmem_addr[8:2] == 8'b10001001) ? dmem_writedata : k45;
				// k46 <= (dmem_addr[8:2] == 8'b10001010) ? dmem_writedata : k46;
				// k47 <= (dmem_addr[8:2] == 8'b10001011) ? dmem_writedata : k47;
				// k48 <= (dmem_addr[8:2] == 8'b10001100) ? dmem_writedata : k48;
				// k48 <= (dmem_addr[8:2] == 8'b10001100) ? dmem_writedata : k48;
				// k49 <= (dmem_addr[8:2] == 8'b10001101) ? dmem_writedata : k49;
				// k50 <= (dmem_addr[8:2] == 8'b10001110) ? dmem_writedata : k50;
				// k51 <= (dmem_addr[8:2] == 8'b10001111) ? dmem_writedata : k51;
				// k52 <= (dmem_addr[8:2] == 8'b10010000) ? dmem_writedata : k52;
				// k53 <= (dmem_addr[8:2] == 8'b10010001) ? dmem_writedata : k53;
				// k54 <= (dmem_addr[8:2] == 8'b10010010) ? dmem_writedata : k54;
				// k55 <= (dmem_addr[8:2] == 8'b10010011) ? dmem_writedata : k55;
				// k56 <= (dmem_addr[8:2] == 8'b10010100) ? dmem_writedata : k56;
				// k57 <= (dmem_addr[8:2] == 8'b10010101) ? dmem_writedata : k57;
				// k58 <= (dmem_addr[8:2] == 8'b10010110) ? dmem_writedata : k58;
				// k59 <= (dmem_addr[8:2] == 8'b10010111) ? dmem_writedata : k59;
				// k60 <= (dmem_addr[8:2] == 8'b10011000) ? dmem_writedata : k60;
				// k61 <= (dmem_addr[8:2] == 8'b10011001) ? dmem_writedata : k61;
				// k62 <= (dmem_addr[8:2] == 8'b10011010) ? dmem_writedata : k62;
				// k63 <= (dmem_addr[8:2] == 8'b10011011) ? dmem_writedata : k63;

			end
			else begin
//				state0 <= state0;
//				state1 <= state1;
//				state2 <= state2;
//				state3 <= state3;
//				state4 <= state4;
//				state5 <= state5;
//				state6 <= state6;			
//				state7 <= state7;
				// m0<= (cnt==16'd0)? {D0[7:0],D0[15:8],D0[23:16],D0[31:24]} :m0;
				// m1<= (cnt==16'd0)? {D1[7:0],D1[15:8],D1[23:16],D1[31:24]} :m1;
				// m2<= (cnt==16'd0)? {D2[7:0],D2[15:8],D2[23:16],D2[31:24]} :m2;
				// m3<= (cnt==16'd0)? {D3[7:0],D3[15:8],D3[23:16],D3[31:24]} :m3;
				// m4<= (cnt==16'd0)? {D4[7:0],D4[15:8],D4[23:16],D4[31:24]} :m4;
				// m5<= (cnt==16'd0)? {D5[7:0],D5[15:8],D5[23:16],D5[31:24]} :m5;
				// m6<= (cnt==16'd0)? {D6[7:0],D6[15:8],D6[23:16],D6[31:24]} :m6;
				// m7<= (cnt==16'd0)? {D7[7:0],D7[15:8],D7[23:16],D7[31:24]} :m7;
				// m8<= (cnt==16'd0)? {D8[7:0],D8[15:8],D8[23:16],D8[31:24]} :m8;
				// m9<= (cnt==16'd0)? {D9[7:0],D9[15:8],D9[23:16],D9[31:24]} :m9;
				// m10<= (cnt==16'd0)? {D10[7:0],D10[15:8],D10[23:16],D10[31:24]} :m10;
				// m11<= (cnt==16'd0)? {D11[7:0],D11[15:8],D11[23:16],D11[31:24]} :m11;
				// m12<= (cnt==16'd0)? {D12[7:0],D12[15:8],D12[23:16],D12[31:24]} :m12;
				// m13<= (cnt==16'd0)? {D13[7:0],D13[15:8],D13[23:16],D13[31:24]} :m13;
				// m14<= (cnt==16'd0)? {D14[7:0],D14[15:8],D14[23:16],D14[31:24]} :m14;
				// m15<= (cnt==16'd0)? {D15[7:0],D15[15:8],D15[23:16],D15[31:24]} :m15;

				// m16<= (cnt==16'd1)? {`SIG1(m14) + m9 + `SIG0(m1) + m0} :m16;
				// m17<= (cnt==16'd1)? {`SIG1(m15) + m10 + `SIG0(m2) + m1} :m17;

				// m18<= (cnt==16'd2)? {`SIG1(m16) + m11 + `SIG0(m3) + m2} :m18;
				// m19<= (cnt==16'd2)? {`SIG1(m17) + m12 + `SIG0(m4) + m3} :m19;

				// m20<= (cnt==16'd3)? {`SIG1(m18) + m13 + `SIG0(m5) + m4} :m20;
				// m21<= (cnt==16'd3)? {`SIG1(m19) + m14 + `SIG0(m6) + m5} :m21;
				
				// m22 <= (cnt == 16'd4) ? {`SIG1(m20) + m15 + `SIG0(m7) + m6} : m22;
				// m23 <= (cnt == 16'd4) ? {`SIG1(m21) + m16 + `SIG0(m8) + m7} : m23;

				// m24 <= (cnt == 16'd5) ? {`SIG1(m22) + m17 + `SIG0(m9) + m8} : m24;
				// m25 <= (cnt == 16'd5) ? {`SIG1(m23) + m18 + `SIG0(m10) + m9} : m25;

				// m26 <= (cnt == 16'd6) ? {`SIG1(m24) + m19 + `SIG0(m11) + m10} : m26;
				// m27 <= (cnt == 16'd6) ? {`SIG1(m25) + m20 + `SIG0(m12) + m11} : m27;

				// m28 <= (cnt == 16'd7) ? {`SIG1(m26) + m21 + `SIG0(m13) + m12} : m28;
				// m29 <= (cnt == 16'd7) ? {`SIG1(m27) + m22 + `SIG0(m14) + m13} : m29;

				// m30 <= (cnt == 16'd8) ? {`SIG1(m28) + m23 + `SIG0(m15) + m14} : m30;
				// m31 <= (cnt == 16'd8) ? {`SIG1(m29) + m24 + `SIG0(m16) + m15} : m31;

				// m32 <= (cnt == 16'd9) ? {`SIG1(m30) + m25 + `SIG0(m17) + m16} : m32;
				// m33 <= (cnt == 16'd9) ? {`SIG1(m31) + m26 + `SIG0(m18) + m17} : m33;

				// m34 <= (cnt == 16'd10) ? {`SIG1(m32) + m27 + `SIG0(m19) + m18} : m34;
				// m35 <= (cnt == 16'd10) ? {`SIG1(m33) + m28 + `SIG0(m20) + m19} : m35;

				// m36 <= (cnt == 16'd11) ? {`SIG1(m34) + m29 + `SIG0(m21) + m20} : m36;
				// m37 <= (cnt == 16'd11) ? {`SIG1(m35) + m30 + `SIG0(m22) + m21} : m37;

				// m38 <= (cnt == 16'd12) ? {`SIG1(m36) + m31 + `SIG0(m23) + m22} : m38;
				// m39 <= (cnt == 16'd12) ? {`SIG1(m37) + m32 + `SIG0(m24) + m23} : m39;

				// m40 <= (cnt == 16'd13) ? {`SIG1(m38) + m33 + `SIG0(m25) + m24} : m40;
				// m41 <= (cnt == 16'd13) ? {`SIG1(m39) + m34 + `SIG0(m26) + m25} : m41;

				// m42 <= (cnt == 16'd14) ? {`SIG1(m40) + m35 + `SIG0(m27) + m26} : m42;
				// m43 <= (cnt == 16'd14) ? {`SIG1(m41) + m36 + `SIG0(m28) + m27} : m43;

				// m44 <= (cnt == 16'd15) ? {`SIG1(m42) + m37 + `SIG0(m29) + m28} : m44;
				// m45 <= (cnt == 16'd15) ? {`SIG1(m43) + m38 + `SIG0(m30) + m29} : m45;

				// m46 <= (cnt == 16'd16) ? {`SIG1(m44) + m39 + `SIG0(m31) + m30} : m46;
				// m47 <= (cnt == 16'd16) ? {`SIG1(m45) + m40 + `SIG0(m32) + m31} : m47;

				// m48 <= (cnt == 16'd17) ? {`SIG1(m46) + m41 + `SIG0(m33) + m32} : m48;
				// m49 <= (cnt == 16'd17) ? {`SIG1(m47) + m42 + `SIG0(m34) + m33} : m49;

				// m50 <= (cnt == 16'd18) ? {`SIG1(m48) + m43 + `SIG0(m35) + m34} : m50;
				// m51 <= (cnt == 16'd18) ? {`SIG1(m49) + m44 + `SIG0(m36) + m35} : m51;

				// m52 <= (cnt == 16'd19) ? {`SIG1(m50) + m45 + `SIG0(m37) + m36} : m52;
				// m53 <= (cnt == 16'd19) ? {`SIG1(m51) + m46 + `SIG0(m38) + m37} : m53;

				// m54 <= (cnt == 16'd20) ? {`SIG1(m52) + m47 + `SIG0(m39) + m38} : m54;
				// m55 <= (cnt == 16'd20) ? {`SIG1(m53) + m48 + `SIG0(m40) + m39} : m55;

				// m56 <= (cnt == 16'd21) ? {`SIG1(m54) + m49 + `SIG0(m41) + m40} : m56;
				// m57 <= (cnt == 16'd21) ? {`SIG1(m55) + m50 + `SIG0(m42) + m41} : m57;

				// m58 <= (cnt == 16'd22) ? {`SIG1(m56) + m51 + `SIG0(m43) + m42} : m58;
				// m59 <= (cnt == 16'd22) ? {`SIG1(m57) + m52 + `SIG0(m44) + m43} : m59;

				// m60 <= (cnt == 16'd23) ? {`SIG1(m58) + m53 + `SIG0(m45) + m44} : m60;
				// m61 <= (cnt == 16'd23) ? {`SIG1(m59) + m54 + `SIG0(m46) + m45} : m61;

				// m62 <= (cnt == 16'd24) ? {`SIG1(m60) + m55 + `SIG0(m47) + m46} : m62;
				// m63 <= (cnt == 16'd24) ? {`SIG1(m61) + m56 + `SIG0(m48) + m47} : m63;
				end	
		cnt <= go_bit_in? 16'h00 : done_bit_in ? cnt : cnt +16'h01;
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


		7'b1011101: dmem_rdata_local = DataLen;
		7'b1011110:dmem_rdata_local = DataLen;
		DataLen <= (dmem_addr[8:2] == 7'b1011101) ? dmem_writedata : DataLen;
		BitLen0 <= (dmem_addr[8:2] == 7'b1011110) ? dmem_writedata : BitLen0;
		BitLen1 <= (dmem_addr[8:2] == 7'b1011111) ? dmem_writedata : BitLen1;

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
		
	//always @(m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,cnt) begin
		
	//case(cnt)
		//0-15
		//16'b0:
				//m0 = D[7:0] << 24| D0[15:8] | D[24:16]
				// m0 = (D0 << 24) | (D1 << 16) | (D2 << 8) | (D3);
			  	// m1 = (D1 << 24) | (D2 << 16) | (D3 << 8) | (D4);
			    // m2  = (D2 << 24) | (D3 << 16) | (D4 << 8) | D5;
				// m3  = (D3 << 24) | (D4 << 16) | (D5 << 8) | D6;
				// m4  = (D4 << 24) | (D5 << 16) | (D6 << 8) | D7;
				// m5  = (D5 << 24) | (D6 << 16) | (D7 << 8) | D8;
				// m6  = (D6 << 24) | (D7 << 16) | (D8 << 8) | D9;
				// m7  = (D7 << 24) | (D8 << 16) | (D9 << 8) | D10;
				// m8  = (D8 << 24) | (D9 << 16) | (D10 << 8) | D11;
				// m9  = (D9 << 24) | (D10 << 16) | (D11 << 8) | D12;
				// m10 = (D10 << 24) | (D11 << 16) | (D12 << 8) | D13;
				// m11 = (D11 << 24) | (D12 << 16) | (D13 << 8) | D14;
				// m12 = (D12 << 24) | (D13 << 16) | (D14 << 8) | D15;
				// m13 = (D13 << 24) | (D14 << 16) | (D15 << 8) | D16;
				// m14 = (D14 << 24) | (D15 << 16) | (D16 << 8) | D17;
				// m15 = (D15 << 24) | (D16 << 16) | (D17 << 8) | D18;
		// 16,17
		// 16'b01: 
		// 	m16=((ROTRIGHT(m14, 17) ^ ROTRIGHT(m14, 19) ^ ((m14) >> 10))) + m9 + (ROTRIGHT(m1, 7) ^ ROTRIGHT(m1, 18) ^ ((m1) >> 3)) + m0;
		// 	SIG0(m1) 
		// 	m17=sig1(m15) + m10 + sig0(m2) + m1;

		//m[i] = SIG1(m[i - 2]) + m[i - 7] + SIG0(m[i - 15]) + m[i - 16];
		//SIG0(x) (ROTRIGHT(x, 7) ^ ROTRIGHT(x, 18) ^ ((x) >> 3))
		//SIG1(x) (ROTRIGHT(x, 17) ^ ROTRIGHT(x, 19) ^ ((x) >> 10))
		//ROTLEFT(a, b) (((a) << (b)) | ((a) >> (32 - (b))))
	    //ROTRIGHT(a, b) (((a) >> (b)) | ((a) << (32 - (b))))

	//endcase


	 		//expanded the input to 32 bit.
	 always @(data_A, counter) begin
		case(counter)
		16'b0: 	in1 = data_A[7:0];
		16'b1:	in1 = data_A[15:8];
		16'b10: in1 = data_A[23:16];
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
	 assign done_bit_in = (counter == 16'd25);
	 
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