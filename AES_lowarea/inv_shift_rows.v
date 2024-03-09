module inv_shift_rows(    
    input wire [127:0] sr_in,
    output reg [127:0] sr_out
	);
	
	always @(*)begin
	  //Shift Rows
	    sr_out[7:0] = sr_in[7:0];
	    sr_out[15:8] = sr_in[111:104];
	    sr_out[23:16] = sr_in[87:80];
	    sr_out[31:24] = sr_in[63:56];
	
	    sr_out[39:32] = sr_in[39:32];
	    sr_out[47:40] = sr_in[15:8];
	    sr_out[55:48] = sr_in[119:112];
	    sr_out[63:56] = sr_in[95:88];
	
	    sr_out[71:64] = sr_in[71:64];
	    sr_out[79:72] = sr_in[47:40];
	    sr_out[87:80] = sr_in[23:16];
	    sr_out[95:88] = sr_in[127:120];
	
	    sr_out[103:96] = sr_in[103:96];
	    sr_out[111:104] = sr_in[79:72];
	    sr_out[119:112] = sr_in[55:48];
	    sr_out[127:120] = sr_in[31:24];
    end

endmodule
