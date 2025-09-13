`timescale 1ns / 1ps

module tb_ID_stage;

    reg clk;
    reg [4:0] pvrd;
    reg [31:0] instruction;

    wire [5:0] opcode;
    wire [4:0] rt;
    wire [4:0] rs;
    wire [4:0] rd;
    wire [4:0] sa;
    wire [5:0] funct;
    wire [25:0] instr_address;
    wire [15:0] Adress_Immediate;
    wire [1:0] InstructionType;
    wire stall;

    ID_stage dut (
        .clk(clk),
        .pvrd(pvrd),
        .instruction(instruction),
        .opcode(opcode),
        .rt(rt),
        .rs(rs),
        .rd(rd),
        .sa(sa),
        .funct(funct),
        .instr_address(instr_address),
        .Adress_Immediate(Adress_Immediate),
        .InstructionType(InstructionType),
        .stall(stall)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        instruction = 32'b000000_01000_01001_01010_00000_100000; // add $t2, $t0, $t1
        pvrd = 5'd8; // Previous RD is $t0, causing a hazard with rs
        #10;
        $display("pvrd: %d, rs: %d, rt: %d -> STALL: %b", pvrd, rs, rt, stall);
        $finish;
    end

endmodule

