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
    wire [15:0] Adress_Immediate;// immediate value
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
    wire [5:0] opcodel3,functl3;
    wire [31:0] write_material,pc_vall3,outpcl3, Rs,Rt,Rsl3,Rtl3,immedl3; //this too will be used to write back in mem stage later to registers
    wire [4:0] write_address,sal3,rtl3;           //later in mem stage i will need to use this to write back to registers
    registerFile d(readadd1,readadd2,write_address,clk,write,write_material,Rs,Rt);

    Rego32 B1(clk2,Rs,Rsl3);
    Rego32 B2(clk2,Rt,Rtl3);
    Rego32 B3(clk2,immed,immedl3);
    Rego6 B4(clk2,opcode,opcodel3);
    Rego32 B5(clk2,pc_val,pc_vall3);
    Rego32 B6(clk2,outpc,outpcl3);
    Rego6 B7(clk2,funct,functl3);
    Rego5 B8(clk2,sa,sal3);
    Rego5 B9(clk2,rt,rtl3);

    // assign outx = Rs;
    wire [31:0] Output_;
    ALU e(
        .clk(clk),
        .opcode(opcodel3), // correct       sent
        .SRC(Rsl3),                         //sent
        .TARG(Rtl3),                        //sent
        .immediateVal(immedl3), 
        .funct(functl3),
        .shamt(sal3),
        .pc(pc_vall3),
        .inpc(outpcl3),
        .Outp(Output_)                      //sent
    );
    // assign outx = Output_ ;
    wire [5:0] opcodel4;
    wire [4:0] rtl4;
    wire [31:0] Rsl4,Rtl4,Output_l4;
    Rego6 C1(clk1,opcodel3,opcodel4);
    Rego5 C2(clk1,rtl3,rtl4);
    // Rego32 C2(clk1,Rsl3,Rsl4);
    Rego32 C3(clk1,Rtl3,Rtl4);
    Rego32 C4(clk1,Output_,Output_l4);

    MEM_stage f(clk,opcodel4,rtl4,Rtl4,Output_l4,write_material,write,write_address);
    assign outx = Output_l4;

endmodule