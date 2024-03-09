module mul_gf24(
	input [3:0] a
	,input [3:0] b
	,output reg [3:0] q
);
	reg aA;
	reg aB;
	always @(*)begin
		aA=a[0]^a[3];
		aB=a[2]^a[3];
		q[0]=(a[0]&b[0])^(a[3]&b[1])^(a[2]&b[2])^(a[1]&b[3]);
		q[1]=(a[1]&b[0])^(aA&b[1])^(aB&b[2])^((a[1]^a[2])&b[3]);
		q[2]=(a[2]&b[0])^(a[1]&b[1])^(aA&b[2])^(aB&b[3]);
		q[3]=(a[3]&b[0])^(a[2]&b[1])^(a[1]&b[2])^(aA&b[3]);
	end
endmodule