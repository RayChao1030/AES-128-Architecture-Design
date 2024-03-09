module last_round(
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
wire [127:0] ark_in;
wire [127:0] ark_out;
wire [127:0] select_round_key;

//modules
sub_bytes sb(.in(in),.out(sb_out),.sel(sel));
shift_rows sr(.sr_in(sb_out),.sr_out(sr_out));
inv_shift_rows isr(.sr_in(sb_out),.sr_out(isr_out));
add_round_key ark(.in(ark_in),.round_key(in_key),.out(ark_out));


//mux assign
//assign ark_in
assign ark_in = sel? isr_out : sr_out;
//assign in_key
assign in_key = sel? dec_key : enc_key;

//assign
assign out = ark_out;


endmodule