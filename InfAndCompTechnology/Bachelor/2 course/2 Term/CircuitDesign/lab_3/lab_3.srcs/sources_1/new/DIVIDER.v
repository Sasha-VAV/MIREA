`timescale 1ns / 1ps
module DIVIDER#(DIVISOR = 36)(
    input clk,
    output reg divided_clk
);
reg [$clog2(DIVISOR) - 1 : 0] counter;
initial
begin
    counter = 0;
    divided_clk = 0;
end
always @(posedge clk)
begin
    counter <= counter + 1'b1;
    if(counter >= (DIVISOR - 1))
    begin
        counter <= 1'b0;
        divided_clk = 1;
    end
    else
        divided_clk = 0;
end
endmodule