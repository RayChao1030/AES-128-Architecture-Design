`timescale 1ns/10ps
`define INTERVAL 10

module sbox_tb;
	reg   [7:0]in;
	wire  [7:0]out;
	wire  [7:0]in_check;
  
  
	sbox sbox(.in(in),.out(out),.in_check(in_check));
  
	
	integer i,j;
	initial begin
	$monitor($time,"ns, in=%h, out=%h, in_check=%h",in,out,in_check);
	end
	

	initial begin
			   in = 8'h00;
	#`INTERVAL in = 8'h01;
	#`INTERVAL in = 8'h02;
	#`INTERVAL in = 8'h03;
	#`INTERVAL in = 8'h04;
	#`INTERVAL in = 8'h05;
	#`INTERVAL $finish;
	end


initial 
begin
	`ifdef FSDB
		$fsdbDumpfile("sbox.fsdb");
		$fsdbDumpvars(0, sbox);
	`endif
end
  
endmodule
