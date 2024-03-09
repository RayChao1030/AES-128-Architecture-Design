module round(
input [127:0] in,
input [127:0] enc_key,
input [127:0] dec_key,
input sel,

output [127:0] out
);

//wires
wire [127:0] in_key;
wire [127:0] sb_out;
wire [127:0] sr_out;
wire [127:0] isr_out;
wire [127:0] mc_out;
wire [127:0] imc_out;
wire [127:0] ark_in;
wire [127:0] ark_out;
wire [127:0] select_round_key;
wire [127:0] imc_dec_key;

//modules
sub_bytes sb(.in(in),.out(sb_out),.sel(sel));
shift_rows sr(.sr_in(sb_out),.sr_out(sr_out));
inv_shift_rows isr(.sr_in(sb_out),.sr_out(isr_out));
mix_columns mc(.mc_in(sr_out),.mc_out(mc_out));
inv_mix_columns imc1(.mc_in(isr_out),.mc_out(imc_out));
add_round_key ark(.in(ark_in),.round_key(in_key),.out(ark_out));
inv_mix_columns imc2(.mc_in(dec_key),.mc_out(imc_dec_key));


//mux assign
//assign ark_in
assign ark_in = sel? imc_out : mc_out;
//assign in_key
assign in_key = sel? imc_dec_key : enc_key;

//assign
assign out = ark_out;


endmodule