module datapath(
    input clk1,
    input clk2,
    input clk,
    output [31:0] out1A
);
    reg stall=0;
    reg jump_cs=0;
    wire [31:0] instruction,next_pc;
    // reg [31:0] out1A;
    IF_stage a(clk,stall,next_pc,jump_cs,instruction);

    Rego32 A(clk1,instruction,out1A);

    wire [5:0] opcode;
    wire [4:0] rt;               // target register
    wire [4:0] rs;               // source register
    wire [4:0] rd;               // destination register
    wire [4:0] sa;               // shift amount
    wire [5:0] funct;            // function field (goes to ALU)
    wire [25:0] instr_address;   // jump address
    wire [14:0] Adress_Immediate;// immediate value
    wire [1:0] InstructionType;  // type of instruction

    // Instantiate ID_stage
    ID_stage b (
        .clk(clk),
        .instruction(out1A),
        .opcode(opcode),
        .rt(rt),
        .rs(rs),
        .rd(rd),
        .sa(sa),
        .funct(funct),
        .instr_address(instr_address),
        .Adress_Immediate(Adress_Immediate),
        .InstructionType(InstructionType)
    );
    wire [5:0] opcodel1,opcodel2,functl1,functl2;
    wire [4:0] rtl1,rtl2,rsl1,rsl2,rdl1,rdl2,sal1,sal2;
    wire [25:0] instr_addressl1,instr_addressl2;
    wire [14:0] Adress_Immediatel1,Adress_Immediatel2;
    wire [1:0] InstructionTypel1,InstructionTypel2;

    Rego6 B1(clk2,opcode,opcodel2);
    Rego6 B2(clk2,funct,functl2);
    Rego5 B3(clk2,rt,rtl2);
    Rego B4(clk2,rs,rsl2);
    Rego B5(clk2,rd,rdl2);
    Rego B6(clk2,sa,sal2);
    Rego B7(clk2,instr_address,instr_addressl2);
    Rego B8(clk2,Adress_Immediate,Adress_Immediatel2);
    Rego B9(clk2,InstructionType,InstructionTypel2);

    ALU c(
        .clk(clk),
        .opcode(opcodel2),
        .SRC(rsl2),
        .TARG(rtl2),
        .immediateVal
    )

endmodule