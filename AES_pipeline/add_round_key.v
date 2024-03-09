module add_round_key(
    input [127:0] round_key,
    input [127:0] in,
    output reg [127:0] out
	);
	
	always @(*)begin
    	//Add Round Key
        out = in[127:0] ^ round_key[127:0];
    end
    		
endmodule