`timescale 1ns / 1ps
module main(
    input clk,
    input PS_2_clk,
    input PS_2_data,
    output [7:0] AN,
    output [6:0] SEG,
    output LED
);

wire [9:0] ps2_data_compl;
reg [9:0] delay_data;
wire ps2_data_ex, ps_reset;
always @(posedge clk)
begin
    delay_data <= ps2_data_compl;
end

PS2_manager ps_2(
    .clk(clk),
    .PS_2_clk(PS_2_clk),
    .PS_2_data(PS_2_data),
    .reset(1'b0),
    .R_O(ps2_data_ex),
    .out(ps2_data_compl),
    .escape(ps_reset)
);

wire [3:0] chastnoe, ostatok;
wire [2:0] ERROR;

Division del(
    .clk(clk),
    .R_I(ps2_data_ex),
    .reset(ps_reset),
    .dataIn(delay_data),
    .R_O(LED),
    .Res(chastnoe),
    .Remains(ostatok),
    .ERR(ERROR)
);

wire clk_div_out;
DIVIDER #(.DIVISOR(8000)) divide(
    .clk(clk),
    .divided_clk(clk_div_out)
);

SevenSegmentLED seg(
    .clk(clk_div_out),
    .RESET(ps_reset),
    .NUMBER({chastnoe,4'b0,ostatok,5'b0,ERROR,2'b0, delay_data}),
    .AN_MASK({8'b01010100}),
    .AN(AN),
    .SEG(SEG)
);

endmodule