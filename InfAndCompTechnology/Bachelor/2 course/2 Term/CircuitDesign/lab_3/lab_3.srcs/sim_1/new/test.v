`timescale 1ns / 1ps
module test();
reg clk = 0, pclk, pdata;
wire [7:0] AN;
wire [6:0] SEG;
reg [3:0] i = 0;
wire LED;
reg [7:0] num;
reg is_even;

// Initializing params
reg [7:0] NUMBERS [0:15];
parameter [7:0] ENTER_CODE = 8'h5A;
parameter [7:0] UNPRESS_CODE = 8'hF0;
parameter [7:0] ESC_CODE = 8'h76;
initial begin 
    NUMBERS[0] = 8'h45; 
    NUMBERS[1] = 8'h16;
    NUMBERS[2] = 8'h1E;
    NUMBERS[3] = 8'h26;
    NUMBERS[4] = 8'h25;
    NUMBERS[5] = 8'h2E;
    NUMBERS[6] = 8'h36;
    NUMBERS[7] = 8'h3D;
    NUMBERS[8] = 8'h3E;
    NUMBERS[9] = 8'h46;
    NUMBERS[10] = 8'h1C;
    NUMBERS[11] = 8'h32;
    NUMBERS[12] = 8'h21;
    NUMBERS[13] = 8'h23;
    NUMBERS[14] = 8'h24;
    NUMBERS[15] = 8'h2B;
    pdata = 1;
    pclk = 1;
    is_even = 1;
    // Start of test cases
    // 5 / 2 = 2 * 2 + 1
    num = NUMBERS[5];
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = ENTER_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = NUMBERS[2];
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = ENTER_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    #1000;
    
    //Reset
    
    num = ESC_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    #1000;
    
    //reset = 1;
    //#200;
    //reset = 0;
    //#200;
    // Second testcase
    // 5 / 0, expected Err: 1
    num = NUMBERS[5];
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = ENTER_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = NUMBERS[0];
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = ENTER_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    
    num = UNPRESS_CODE;
    is_even = 1;
    #10;
    for (i=0; i<11; i=i+1)
    begin
        case(i)
            0: begin
                pdata = 0;
            end
            1,2,3,4,5,6,7,8: begin
                pdata = num[i-1];
                is_even = is_even + num[i-1];
            end
            9: begin
                pdata = is_even;
            end
            10: begin
                pdata = 1;
            end
        endcase
        #10;
        pclk = 0;
        #10;
        pclk = 1;
    end
    #1000;
    $finish;
end

reg [3:0] number;
reg [31:0] numbers;
always #10
begin
    case (SEG)
        7'b1000000: number = 4'h0;
        7'b1111001: number = 4'h1;
        7'b0100100: number = 4'h2;
        7'b0110000: number = 4'h3;
        7'b0011001: number = 4'h4;
        7'b0010010: number = 4'h5;
        7'b0000010: number = 4'h6;
        7'b1111000: number = 4'h7;
        7'b0000000: number = 4'h8;
        7'b0010000: number = 4'h9;
        7'b0001000: number = 4'ha;
        7'b0000011: number = 4'hb;
        7'b1000110: number = 4'hc;
        7'b0100001: number = 4'hd;
        7'b0000110: number = 4'he;
        7'b0001110: number = 4'hf;
        default: number = 4'hx;
    endcase
    if (~AN[0])
        numbers[3:0] = number;
    if (~AN[1])
        numbers[7:4] = number;
    if (~AN[2])
        numbers[11:8] = number;
    if (~AN[3])
        numbers[15:12] = number;
    if (~AN[4])
        numbers[19:16] = number;
    if (~AN[5])
        numbers[23:20] = number;
    if (~AN[6])
        numbers[27:24] = number;
    if (~AN[7])
        numbers[31:28] = number;
end
always#5 clk=~clk;
main m(
    .clk(clk),
    .PS_2_clk(pclk),
    .PS_2_data(pdata),
    .AN(AN),
    .SEG(SEG),
    .LED(LED)
);

endmodule