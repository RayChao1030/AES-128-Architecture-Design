`include"sub_bytes.v"
`include"mix_columns.v"
`include"add_round_key.v"
`include"key_expansion.v"
`include"key_scheduler.v"
`include"round.v"
`include"last_round.v"

module aes128_pip(
input [127:0] in,
input [127:0] key,
input clk,
input rst,
input sel, //0->encrpt 1->decrypt

output [127:0] out
);

//reg
reg [127:0] round1_reg;
reg [127:0] round2_reg;
reg [127:0] round3_reg;
reg [127:0] round4_reg;
reg [127:0] round5_reg;
reg [127:0] round6_reg;
reg [127:0] round7_reg;
reg [127:0] round8_reg;
reg [127:0] round9_reg;
reg [127:0] round10_reg;

//wire
wire [127:0] in_key;
wire [127:0] round_key [0:10];
wire [1407:0] expanded_key;
wire [127:0] round1_reg_in;
wire [127:0] round2_reg_in;
wire [127:0] round3_reg_in;
wire [127:0] round4_reg_in;
wire [127:0] round5_reg_in;
wire [127:0] round6_reg_in;
wire [127:0] round7_reg_in;
wire [127:0] round8_reg_in;
wire [127:0] round9_reg_in;
wire [127:0] round10_reg_in;
wire [127:0] ark_in;

//seq ff
always@(posedge clk)begin
	if(rst)begin
		round1_reg <= 128'd0;
		round2_reg <= 128'd0;
		round3_reg <= 128'd0;
		round4_reg <= 128'd0;
		round5_reg <= 128'd0;
		round6_reg <= 128'd0;
		round7_reg <= 128'd0;
		round8_reg <= 128'd0;
		round9_reg <= 128'd0;
		round10_reg <= 128'd0;
	end
	else begin
		round1_reg <= round1_reg_in;
		round2_reg <= round2_reg_in;
		round3_reg <= round3_reg_in;
		round4_reg <= round4_reg_in;
		round5_reg <= round5_reg_in;
		round6_reg <= round6_reg_in;
		round7_reg <= round7_reg_in;
		round8_reg <= round8_reg_in;
		round9_reg <= round9_reg_in;
		round10_reg <= round10_reg_in;
	end
end

//modules
add_round_key ark(.in(ark_in),.round_key(in_key),.out(round1_reg_in));
key_expansion ke(.key(key),.w(expanded_key));
key_scheduler ks(.expanded_key(expanded_key),.round0_key(round_key[0]),.round1_key(round_key[1]),.round2_key(round_key[2]),.round3_key(round_key[3]),.round4_key(round_key[4]),.round5_key(round_key[5]),.round6_key(round_key[6]),.round7_key(round_key[7]),.round8_key(round_key[8]),.round9_key(round_key[9]),.round10_key(round_key[10]));
round round1(.in(round1_reg),.enc_key(round_key[1]),.dec_key(round_key[9]),.sel(sel),.out(round2_reg_in));
round round2(.in(round2_reg),.enc_key(round_key[2]),.dec_key(round_key[8]),.sel(sel),.out(round3_reg_in));
round round3(.in(round3_reg),.enc_key(round_key[3]),.dec_key(round_key[7]),.sel(sel),.out(round4_reg_in));
round round4(.in(round4_reg),.enc_key(round_key[4]),.dec_key(round_key[6]),.sel(sel),.out(round5_reg_in));
round round5(.in(round5_reg),.enc_key(round_key[5]),.dec_key(round_key[5]),.sel(sel),.out(round6_reg_in));
round round6(.in(round6_reg),.enc_key(round_key[6]),.dec_key(round_key[4]),.sel(sel),.out(round7_reg_in));
round round7(.in(round7_reg),.enc_key(round_key[7]),.dec_key(round_key[3]),.sel(sel),.out(round8_reg_in));
round round8(.in(round8_reg),.enc_key(round_key[8]),.dec_key(round_key[2]),.sel(sel),.out(round9_reg_in));
round round9(.in(round9_reg),.enc_key(round_key[9]),.dec_key(round_key[1]),.sel(sel),.out(round10_reg_in));
last_round round10(.in(round10_reg),.enc_key(round_key[10]),.dec_key(round_key[0]),.sel(sel),.out(out));

//assign
//mux
assign in_key = sel? round_key[10] : round_key[0];
assign ark_in=in;

//comb
/*always@(*)begin
	if(sel) in_key = round_key[10];
	else in_key = round_key[0];
end
*/
endmodule