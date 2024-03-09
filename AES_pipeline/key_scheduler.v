module key_scheduler(
	input [1407:0] expanded_key,
	output reg [127:0] round0_key,
	output reg [127:0] round1_key,
	output reg [127:0] round2_key,
	output reg [127:0] round3_key,
	output reg [127:0] round4_key,
	output reg [127:0] round5_key,
	output reg [127:0] round6_key,
	output reg [127:0] round7_key,	
	output reg [127:0] round8_key,
	output reg [127:0] round9_key,
	output reg [127:0] round10_key
	);
	
	always @(*)begin
		round10_key= expanded_key[127:0];
	    round9_key = expanded_key[255:128];
	    round8_key = expanded_key[383:256];
	    round7_key = expanded_key[511:384];
	    round6_key = expanded_key[639:512];
	    round5_key = expanded_key[767:640];
	    round4_key = expanded_key[895:768];
	    round3_key = expanded_key[1023:896];
	    round2_key = expanded_key[1151:1024];
	    round1_key = expanded_key[1279:1152];
	    round0_key = expanded_key[1407:1280];
    end

endmodule