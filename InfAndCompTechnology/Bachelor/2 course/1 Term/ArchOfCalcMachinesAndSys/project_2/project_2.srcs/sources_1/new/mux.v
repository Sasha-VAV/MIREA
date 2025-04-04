`timescale 1ns / 1ps
module mux#(width = 2)(
    input [width - 1:0] a,
    input [0: 2**(width) - 1] inputs,
    input enable,
    output f
    );
    assign f = enable && inputs[a];
endmodule
