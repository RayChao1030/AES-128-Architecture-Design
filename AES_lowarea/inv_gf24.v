module inv_gf24(
	input [3:0]a
	,output reg [3:0]q
);
	reg aA;
	always @(*)begin
		aA=a[1]^a[2]^a[3]^(a[1]&a[2]&a[3]);
		q[0]=aA^a[0]^(a[0]&a[2])^(a[1]&a[2])^(a[0]&a[1]&a[2]);
		q[1]=(a[0]&a[1])^(a[0]&a[2])^(a[1]&a[2])^a[3]^(a[1]&a[3])^(a[0]&a[1]&a[3]);
		q[2]=(a[0]&a[1])^a[2]^(a[0]&a[2])^a[3]^(a[0]&a[3])^(a[0]&a[2]&a[3]);
		q[3]=aA^(a[0]&a[3])^(a[1]&a[3])^(a[2]&a[3]);
	end
endmodule
