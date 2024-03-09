`include"sub_bytes.v"
`include"mix_columns.v"
`include"add_round_key.v"
`include"key_expansion.v"
`include"key_scheduler.v"

module aes128_top(
input [127:0] in,
input [127:0] key,
input clk,
input rst,

output reg [5:0] state,
output [127:0] out,
output reg sel
);

//regs
reg [127:0] data_reg;
//reg [5:0] state;

//wires
wire [1407:0] expanded_key;
wire [127:0] round_key [0:10];
wire [127:0] round_key_inv;
wire [127:0] ark1_out;
wire [127:0] ark2_out;
wire [127:0] sb_out;
wire [127:0] sr_out;
wire [127:0] isr_out;
wire [127:0] mc_out;
wire [127:0] imc_out;
reg [127:0] ark1_in;
reg [127:0] ark2_in;
reg [127:0] in_key;
reg [127:0] selected_round_key; 
reg [127:0] imc2_in;
//reg sel;

//modules
key_expansion ke(.key(key),.w(expanded_key));
key_scheduler ks(.expanded_key(expanded_key),.round0_key(round_key[0]),.round1_key(round_key[1]),.round2_key(round_key[2]),.round3_key(round_key[3]),.round4_key(round_key[4]),.round5_key(round_key[5]),.round6_key(round_key[6]),.round7_key(round_key[7]),.round8_key(round_key[8]),.round9_key(round_key[9]),.round10_key(round_key[10]));
add_round_key ark1(.in(ark1_in),.round_key(in_key),.out(ark1_out));
sub_bytes sb(.in(data_reg),.out(sb_out),.sel(sel));
shift_rows sr(.sr_in(sb_out),.sr_out(sr_out));
inv_shift_rows isr(.sr_in(sb_out),.sr_out(isr_out));
mix_columns mc(.mc_in(sr_out),.mc_out(mc_out));
inv_mix_columns imc1(.mc_in(isr_out),.mc_out(imc_out));
add_round_key ark2(.in(ark2_in),.round_key(selected_round_key),.out(ark2_out));
inv_mix_columns imc2(.mc_in(imc2_in),.mc_out(round_key_inv));

//assign
assign out = data_reg;

//seq state
always@(posedge clk)begin
	if(rst)begin
		state <= 0;
	end
	else begin
		state <= state + 6'd1;
	end
end

//seq ff
always@(posedge clk)begin
	if(rst)begin
		data_reg <= 128'd0;
	end
	else begin
		if(state==6'd0 || state==6'd11)begin
			data_reg <= ark1_out;
		end
		else if(state>=6'd1 && state<=6'd10)begin
			data_reg <= ark2_out;
		end
		else if(state>=6'd12 && state<=6'd21)begin
			data_reg <= ark2_out;
		end
		else if(state==6'd22)begin
			data_reg <= data_reg;
		end
		else begin
			data_reg <= 0;
		end 
	end
end

//comb
always@(*)begin
	//assign selected_round_key
	if(state>=6'd1 && state<=6'd10) selected_round_key = round_key[state];
	else if(state>=6'd12 && state<=6'd20) selected_round_key = round_key_inv;
	else if(state==6'd21) selected_round_key = round_key[0];
	else selected_round_key = 0;

	//assign in_key
	if(state<=6'd10) in_key = round_key[0];
	else in_key = round_key[10];

	//assign ark1_in
	if(state<=6'd10) ark1_in = in;
	else ark1_in = data_reg;

	//assign ark2_in
	if(state<=6'd9) ark2_in = mc_out;
	else if(state==6'd10) ark2_in = sr_out;
	else if(state>=6'd11 && state<=6'd20) ark2_in = imc_out;
	else ark2_in = isr_out;

	//assign imc2_in
	if(state>=6'd12 && state<=6'd20) imc2_in = round_key[21-state];
	else imc2_in = 0;

	//assign sel
	if(state<=6'd11) sel=0;
	else sel=1;
end

endmodule