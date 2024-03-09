`include "mul_inv_gf28.v"
`include "inv_gf24.v"
`include "mul_gf24.v"
module sbox(
	input [7:0]in, 
	input sel, //0->encrypt 1->decrypt

	output reg [7:0] out
);	

	reg [7:0]inv_aff;
	reg [7:0]for_aff;
	reg [7:0]in_mig;

	wire [7:0]out_mig; 

	always@(*)begin
		//inv_affine transform
		inv_aff[0]=in[2]^in[5]^in[7]^1'b1;
		inv_aff[1]=in[0]^in[3]^in[6]^1'b0;
		inv_aff[2]=in[1]^in[4]^in[7]^1'b1;
		inv_aff[3]=in[0]^in[2]^in[5]^1'b0;
		inv_aff[4]=in[1]^in[3]^in[6]^1'b0;
		inv_aff[5]=in[2]^in[4]^in[7]^1'b0;
		inv_aff[6]=in[0]^in[3]^in[5]^1'b0;
		inv_aff[7]=in[1]^in[4]^in[6]^1'b0;
	end
	
	mul_inv_gf28 mig(.in(in_mig),.out(out_mig));

	always@(*)begin
		//affine transform
		for_aff[0]=out_mig[0]^out_mig[4]^out_mig[5]^out_mig[6]^out_mig[7]^1'b1;
		for_aff[1]=out_mig[0]^out_mig[1]^out_mig[5]^out_mig[6]^out_mig[7]^1'b1;
		for_aff[2]=out_mig[0]^out_mig[1]^out_mig[2]^out_mig[6]^out_mig[7]^1'b0;
		for_aff[3]=out_mig[0]^out_mig[1]^out_mig[2]^out_mig[3]^out_mig[7]^1'b0;
		for_aff[4]=out_mig[0]^out_mig[1]^out_mig[2]^out_mig[3]^out_mig[4]^1'b0;
		for_aff[5]=out_mig[5]^out_mig[1]^out_mig[2]^out_mig[3]^out_mig[4]^1'b1;
		for_aff[6]=out_mig[5]^out_mig[6]^out_mig[2]^out_mig[3]^out_mig[4]^1'b1;
		for_aff[7]=out_mig[5]^out_mig[6]^out_mig[7]^out_mig[3]^out_mig[4]^1'b0;
	end

	//mux
	always@(*)begin
		if(sel==1'b0)in_mig=in;
		else in_mig=inv_aff;
		if(sel==1'b0)out=for_aff;
		else out=out_mig;
	end

endmodule

