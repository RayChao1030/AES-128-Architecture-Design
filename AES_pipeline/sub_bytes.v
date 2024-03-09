`include"sbox.v"
module sub_bytes(  
    input [127:0] in,
    input sel,

    output [127:0] out
	);
	  
    sbox s1(.in(in[7:0]),.out(out[7:0]),.sel(sel));      
    sbox s2(.in(in[15:8]),.out(out[15:8]),.sel(sel));    
    sbox s3(.in(in[23:16]),.out(out[23:16]),.sel(sel));  
    sbox s4(.in(in[31:24]),.out(out[31:24]),.sel(sel));  
    sbox s5(.in(in[39:32]),.out(out[39:32]),.sel(sel));  
    sbox s6(.in(in[47:40]),.out(out[47:40]),.sel(sel));  
    sbox s7(.in(in[55:48]),.out(out[55:48]),.sel(sel));  
    sbox s8(.in(in[63:56]),.out(out[63:56]),.sel(sel));  
    sbox s9(.in(in[71:64]),.out(out[71:64]),.sel(sel));  
    sbox s10(.in(in[79:72]),.out(out[79:72]),.sel(sel));  		
    sbox s11(.in(in[87:80]),.out(out[87:80]),.sel(sel));  	
    sbox s12(.in(in[95:88]),.out(out[95:88]),.sel(sel));      
    sbox s13(.in(in[103:96]),.out(out[103:96]),.sel(sel));    
    sbox s14(.in(in[111:104]),.out(out[111:104]),.sel(sel));  
    sbox s15(.in(in[119:112]),.out(out[119:112]),.sel(sel));  
    sbox s16(.in(in[127:120]),.out(out[127:120]),.sel(sel));  

endmodule