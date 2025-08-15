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

    Rego A(clk1,instruction,out1A);

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


endmodule