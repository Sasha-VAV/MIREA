`timescale 1ns / 1ps


module cpu(
    input clk, reset,
    output [9:0] seq_start, seq_len,
    output valid_out
);

localparam CMD_SIZE = 24;
localparam CMD_MEM_SIZE = 1024;
localparam LIT_SIZE = 10;
localparam DATA_MEM_SIZE = 1024;
localparam RF_SIZE = 16;
localparam ADDR_CMD_MEM_SIZE = $clog2(CMD_MEM_SIZE);
localparam ADDR_DATA_MEM_SIZE = $clog2(DATA_MEM_SIZE);
localparam ADDR_RF_MEM_SIZE = $clog2(RF_SIZE);
localparam KOP_SIZE = 4;
localparam STAGE_COUNT = 5;
localparam NOP = 0, LTM = 1, MTR = 2, RTR = 3, SUB = 4, JUMP_LESS = 5, MTRK = 6, RTMK = 7, JMP = 8, SUM = 9;

reg [CMD_SIZE-1:0] cmd_mem [0 : CMD_MEM_SIZE-1] ;
reg [LIT_SIZE - 1 : 0] mem [0 : DATA_MEM_SIZE-1];
reg [LIT_SIZE - 1 : 0] RF [0 : RF_SIZE-1];
reg [CMD_SIZE-1:0] cmd_reg ;
reg [ADDR_CMD_MEM_SIZE-1 : 0] pc;
reg [2:0] stage_counter;
reg [LIT_SIZE - 1 : 0] op1, op2;
reg [LIT_SIZE - 1 : 0] res;

integer i;
initial
begin
    $readmemb("C:\\Users\\vav11\\Downloads\\program.mem", cmd_mem);
    for(i = 0; i < DATA_MEM_SIZE; i = i + 1)
        mem[i] <= 0;
    for(i = 0; i < RF_SIZE; i = i + 1)
    begin
        RF[i] <= 0;
    end
    cmd_reg <= 0;
    pc <= 0;
    stage_counter <= 0;
    op1 <= 0;
    op2 <= 0;
    res <= 0;
    RF[1] <= 1;
    RF[11] <= 11;
    RF[12] <= 12;
    RF[13] <= 13;
end

wire [KOP_SIZE - 1 : 0] cop = cmd_reg[CMD_SIZE-1 -: KOP_SIZE];
wire [ADDR_DATA_MEM_SIZE - 1 : 0] adr_m_1 = cmd_reg[CMD_SIZE - 1 - KOP_SIZE - 2*ADDR_RF_MEM_SIZE-2 -: ADDR_DATA_MEM_SIZE];
wire [LIT_SIZE - 1 : 0] literal = cmd_reg[CMD_SIZE-1-KOP_SIZE -: LIT_SIZE];


wire [ADDR_RF_MEM_SIZE - 1 : 0] adr_r_1 = cmd_reg[CMD_SIZE - 1 - KOP_SIZE -: ADDR_RF_MEM_SIZE];
wire [ADDR_RF_MEM_SIZE - 1 : 0] adr_r_2 = cmd_reg[CMD_SIZE - 1 - KOP_SIZE - ADDR_RF_MEM_SIZE -: ADDR_RF_MEM_SIZE];
wire [ADDR_RF_MEM_SIZE - 1 : 0] adr_r_3 = cmd_reg[CMD_SIZE - 1 - KOP_SIZE - 2*ADDR_RF_MEM_SIZE -: ADDR_RF_MEM_SIZE];

wire [ADDR_CMD_MEM_SIZE - 1 : 0] adr_to_jmp = cmd_reg[CMD_SIZE - 1 - KOP_SIZE - 2*ADDR_RF_MEM_SIZE-2 -: ADDR_CMD_MEM_SIZE];


always@(posedge clk)
    if(reset)
        stage_counter <= 0;
     else 
        if(stage_counter == 4)
            stage_counter <= 0; 
        else
            stage_counter <= stage_counter + 1;
           
always@(posedge clk)
begin
    if(reset)
        cmd_reg <= 0;
    else
        if(stage_counter == 0)
            cmd_reg <= cmd_mem[pc];
end 

always@(posedge clk)
begin
    if(reset)
        op1 <= 0;
    else
        if(stage_counter == 1)
            case(cop)
                LTM: op1 <= literal;
                MTR: op1 <= mem[adr_m_1];
                RTR, MTRK: op1 <= RF[adr_r_2];
                SUB, JUMP_LESS, RTMK, SUM: op1 <= RF[adr_r_1];
                JMP: op1 <= adr_to_jmp;
            endcase 
end

always@(posedge clk)
begin
    if(reset)
        op2 <= 0;
    else
        if(stage_counter == 2)
            case(cop)
                SUB, SUM, JUMP_LESS: op2 <= RF[adr_r_2];
            endcase 
end

always@(posedge clk)
begin
    if(reset)
        res <= 0;
    else
        if(stage_counter == 3)
            case(cop)
                LTM, MTRK, MTR, RTR, RTMK, JMP: res <= op1;
                SUB: res <= op1 - op2;
                SUM: res <= op1 + op2;
                JUMP_LESS: res <= (op1 >= op2);
            endcase 
end

always@(posedge clk)
begin
    if(reset)
        pc <= 0;
    else
        if(stage_counter == 4)
            case(cop)
                JUMP_LESS: if (res!=0) pc <= adr_to_jmp; else pc <= pc + 1;
                JMP: if (res!=0) pc <= res;
                default: pc <= pc + 1;
            endcase 
end

always@(posedge clk)
begin
    if(reset)
        pc <= 0;
    else
        if(stage_counter == 4)
            case(cop)
                LTM: mem[adr_m_1] <= res;
                MTR, RTR: RF[adr_r_1] <= res;
                SUB, SUM: RF[adr_r_3] <= res;
                MTRK: RF[adr_r_1] <= mem[res];
                RTMK: mem[res] <= RF[adr_r_2];
            endcase 
end

assign seq_start = mem[11];
assign seq_len = mem[12];
assign valid_out = mem[13][0];

endmodule
