`timescale 1ns / 1ps

module test_cpu();

reg clk = 0;
always #5 clk = ~clk;

wire [9:0] seq_start, seq_len;
wire valid_out;
cpu proc(
    .clk(clk),
    .reset(1'b0),
    .seq_start(seq_start),
    .seq_len(seq_len),
    .valid_out(valid_out)
);

endmodule
