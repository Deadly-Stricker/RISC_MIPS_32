module datapath(
    input clk1,
    input clk2,
    input clk,
    output [31:0] outx
);
    wire [31:0]pc_val;
    reg stall=0;
    reg jump_cs=0;
    wire [31:0] instruction,next_pc;
    // reg [31:0] out1A;
    IF_stage a(clk,stall,next_pc,jump_cs,instruction,pc_val);

    wire [31:0] instructionl1,pc_vall1;
    Rego32 A1(clk1,instruction,instructionl1);
    Rego32 A2(clk1,pc_val,pc_vall1);

    wire [5:0] opcode;
    wire [4:0] rt;               // target register
    wire [4:0] rs;               // source register
    wire [4:0] rd;               // destination register
    wire [4:0] sa;               // shift amount
    wire [5:0] funct;            // function field (goes to ALU)
    wire [25:0] instr_address;   // jump address
    wire [14:0] Adress_Immediate;// immediate value
    wire [1:0] InstructionType;  // type of instruction
    wire [31:0] instructionl2,pc_vall2;
    // Instantiate ID_stage
    ID_stage b (
        .clk(clk),
        .instruction(instructionl1),
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
    

    wire [4:0] readadd1,readadd2;
    wire write;
    wire [31:0] immed,outpc;
    controlUnit c(
        .clk(clk),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .sa(sa),
        .funct(funct),
        .instr_address(instr_address),
        .Adress_Immediate(Adress_Immediate),
        .InstructionType(InstructionType),
        .pc(pc_val),
        .readadd1(readadd1),
        .readadd2(readadd2),
        // .write(write),
        .immed(immed),
        .outpc(outpc)
    );
    wire [5:0] opcodel3,functl3,pc_vall3,outpcl3;
    wire [31:0] write_material, Rs,Rt,Rsl3,Rtl3,immedl3; //this too will be used to write back in mem stage later to registers
    wire [4:0] write_address,sal3;           //later in mem stage i will need to use this to write back to registers
    registerFile d(readadd1,readadd2,write_address,clk,write,write_material,Rs,Rt);

    Rego32 B1(clk2,Rs,Rsl3);
    Rego32 B2(clk2,Rt,Rtl3);
    Rego32 B3(clk2,immed,immedl3);
    Rego6 B4(clk2,opcode,opcodel3);
    Rego32 B4(clk2,pc_val,pc_vall3);
    Rego32 B4(clk2,outpc,outpcl3);
    Rego6 B5(clk2,funct,functl3);
    Rego5 B6(clk2,sa,sal3);

    // assign outx = Rs;
    wire Output_;
    ALU e(
        .clk(clk),
        .opcode(opcodel3),
        .SRC(Rsl3),
        .TARG(Rtl3),
        .immediateVal(immedl3),
        .funct(functl3),
        .shamt(sal3),
        .pc(pc_vall3),
        .inpc(outpcl3),
        .outp(Output_)
    );
    assign outx = Output_ ;
endmodule