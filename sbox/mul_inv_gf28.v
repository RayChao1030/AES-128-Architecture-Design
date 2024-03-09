module mul_inv_gf28(
	input [7:0]in 
	,output reg [7:0] out
);	
	//no square function
	reg [3:0] al;
	reg [3:0] ah;
	wire [3:0] d_bef_inv;
	wire [3:0] d_aft_inv;
	wire [3:0] d1_1;
	wire [3:0] d1_2;
	wire [3:0] d2;
	wire [3:0] d3;
	wire [3:0] al_inv;
	wire [3:0] ah_inv;
	reg aA_inv;
	reg aB_inv;
	always@(*)begin
		//mapping
		al[0]=in[4]^in[6]^in[0]^in[5];
		al[1]=in[1]^in[2];
		al[2]=in[1]^in[7];
		al[3]=in[2]^in[4];
		ah[0]=in[4]^in[6]^in[5];
		ah[1]=in[1]^in[7]^in[4]^in[6];
		ah[2]=in[5]^in[7]^in[2]^in[3];
		ah[3]=in[5]^in[7];
	end
	mul_gf24 square_ah(.a(ah),.b(ah),.q(d1_1));
	mul_gf24 mul_e(.a(d1_1),.b(4'b1110),.q(d1_2));
	mul_gf24 ah_mul_al(.a(ah),.b(al),.q(d2));
	mul_gf24 square_al(.a(al),.b(al),.q(d3));
	assign d_bef_inv=d1_2^d2^d3;
	inv_gf24 inv_d(.a(d_bef_inv),.q(d_aft_inv));
	mul_gf24 gen_ah_inv(.a(ah),.b(d_aft_inv),.q(ah_inv));
	mul_gf24 gen_al_inv(.a(ah^al),.b(d_aft_inv),.q(al_inv));
	always@(*)begin
		//inv_mapping
		aA_inv=al_inv[1]^ah_inv[3];
		aB_inv=ah_inv[0]^ah_inv[1];
		out[0]=al_inv[0]^ah_inv[0];
		out[1]=aB_inv^ah_inv[3];
		out[2]=aA_inv^aB_inv;
		out[3]=aB_inv^al_inv[1]^ah_inv[2];
		out[4]=aA_inv^aB_inv^al_inv[3];
		out[5]=aB_inv^al_inv[2];
		out[6]=aA_inv^al_inv[2]^al_inv[3]^ah_inv[0];
		out[7]=aB_inv^al_inv[2]^ah_inv[3];
	end
endmodule

