`timescale 1ns/10ps
`define INTERVAL 10

`ifdef syn
    `include "aes128_pip_syn.v"
    `include "tsmc18.v"
`else
    `include "aes128_pip.v"
`endif

module aes128pip_tb;

	reg rst;
	reg clk;
	reg [127:0]in;
	reg [127:0]key; 
	reg sel;
	wire [127:0]out;
  
	aes128_pip aes1(.clk(clk),.rst(rst),.in(in),.key(key),.out(out),.sel(sel));  
	
	always #1 clk=~clk;

	/*initial begin
	rst=1'b1; clk=1'b0; sel=1'b0; in=128'h6bc1bee22e409f96e93d7e117393172a; key=128'h2b7e151628aed2a6abf7158809cf4f3c; //out=128'h7206720946c642f34a3f00ccfb373457
	#4 rst=0;
	#100 in=128'h7206720946c642f34a3f00ccfb373457; sel=1'b1;
	#100 $finish;
	end*/

	/*initial begin
	rst=1'b1; clk=1'b0; sel=1'b0; in=128'h1212aeae1212aeae8888888888888888; key=128'h2b7e151628aed2a6abf7158809cf4f3c; //out=128'h4874b6241ea8b1031cb5113ca9ee1e54
	#4 rst=0;
	#100 in=128'h4874b6241ea8b1031cb5113ca9ee1e54; sel=1'b1;
	#100 $finish;
	end*/

	initial begin
	rst=1'b1; clk=1'b0; 
	#4 rst=0; sel=1'b0; in=128'h128128aefaef128aef12855555555555; key=128'h2b7e151628aed2a6abf7158809cf4f3c; //out=128'h471667611c17e6379be53e30f5ef5cdd
	#2 in=128'h6bc1bee22e409f96e93d7e117393172a; key=128'h2b7e151628aed2a6abf7158809cf4f3c; //out=128'h7206720946c642f34a3f00ccfb373457
	#2 in=128'h1212aeae1212aeae8888888888888888; key=128'h2b7e151628aed2a6abf7158809cf4f3c; //out=128'h4874b6241ea8b1031cb5113ca9ee1e54

	#100 in=128'h471667611c17e6379be53e30f5ef5cdd; sel=1'b1;
	#2 in=128'h7206720946c642f34a3f00ccfb373457;
	#2 in=128'h4874b6241ea8b1031cb5113ca9ee1e54;

	#100 $finish;
	end

	initial begin
		$monitor($time," out=%h, sel=%d ",out,sel);
	end

	`ifdef syn
        initial $sdf_annotate("aes128_pip_syn.sdf",aes128_pip);
    `endif
 
endmodule