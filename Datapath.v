module datapath(
    // input clk,
    // input clk,
    input clk,
    output [31:0] outx
);
    wire [31:0]pc_val;
    wire stall;
    wire stalldp=0;
    reg jump_cs=0;
    wire [31:0] instruction,next_pc;
    // reg [31:0] out1A;
    IF_stage a(clk,stall,next_pc,jump_cs,instruction,pc_val);

    wire [31:0] instructionl1,pc_vall1;
    Rego32 A1(clk,instruction,stall,instructionl1);
    Rego32 A2(clk,pc_val,stall,pc_vall1);

    wire [5:0] opcode;
    wire [4:0] rt;               // target register
    wire [4:0] rs;               // source register
    wire [4:0] rd;               // destination register
    wire [4:0] prevrd;               // previous destianation register
    wire [4:0] mook;               // previous destianation register that i will use to give id as input
    wire [4:0] sa;               // shift amount
    wire [5:0] funct;            // function field (goes to ALU)
    wire [25:0] instr_address;   // jump address
    wire [15:0] Adress_Immediate;// immediate value
    wire [1:0] InstructionType;  // type of instruction
    wire [31:0] instructionl2,pc_vall2;
    // Instantiate ID_stage
    ID_stage b (
        .clk(clk),
        .pvrd(mook),
        .instruction(instructionl1),
        .opcode(opcode),
        .rt(rt),
        .rs(rs),
        .rd(rd),
        .sa(sa),
        .funct(funct),
        .instr_address(instr_address),
        .Adress_Immediate(Adress_Immediate),
        .InstructionType(InstructionType),
        // .prev_regd(prevrd),
        .stall(stall)
    );
    
    // assign mook = rt;
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
    wire [1:0] InstructionTypel3;
    wire [31:0] write_material,pc_vall3,outpcl3, Rs,Rt,Rsl3,Rtl3,immedl3; //this too will be used to write back in mem stage later to registers
    wire [4:0] write_address,sal3,rtl3,rsl3,rdl3;           //later in mem stage i will need to use this to write back to registers
    assign mook = rtl3;
    
    registerFile d(readadd1,readadd2,write_address,clk,write,write_material,Rs,Rt);

    Rego32 B1(clk,Rs,stall,Rsl3);
    Rego32 B2(clk,Rt,stall,Rtl3);
    Rego32 B3(clk,immed,stall,immedl3);
    Rego6 B4(clk,opcode,stall,opcodel3);
    Rego32 B5(clk,pc_val,stall,pc_vall3);
    Rego32 B6(clk,outpc,stall,outpcl3);
    Rego6 B7(clk,funct,stall,functl3);
    Rego5 B8(clk,sa,,stallsal3);
    Rego5 B9(clk,rt,stall,rtl3);
    Rego5 B11(clk,rs,stall,rsl3);
    Rego5 B12(clk,rd,stall,rdl3);
    Rego2 B10(clk,InstructionType,stall,InstructionTypel3);

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
    wire [4:0] rtl4,rsl4,rdl4;
    wire [31:0] Rsl4,Rtl4,Output_l4;
    wire [1:0] InstructionTypel4;
    Rego6 C1(clk,opcodel3,0,opcodel4);
    Rego5 C2(clk,rtl3,0,rtl4);
    Rego5 C6(clk,rsl3,0,rsl4);
    Rego5 C7(clk,rdl3,0,rdl4);
    // Rego32 C2(clk,Rsl3,Rsl4);
    Rego32 C3(clk,Rtl3 ,0,Rtl4);
    // Rego32 C7(clk,Rdl3 ,Rdl4);
    Rego32 C4(clk,Output_,0,Output_l4);
    Rego2 C5(clk,InstructionTypel3,0,InstructionTypel4);

    wire [31:0] write_material1;
    MEM_stage f(clk,opcodel4,Rtl4,Output_l4,write_material1);
    assign outx = Output_l4;

    wire [5:0] opcodel5;
    wire [4:0] rtl5,rsl5,rdl5;
    wire [1:0] InstructionTypel5;
    wire [31:0] writedata;

    Rego6 D1(clk,opcodel4,0,opcodel5);
    Rego5 D2(clk,rtl4,0,rtl5);
    Rego5 D3(clk,rsl4,0,rsl5);
    Rego5 D6(clk,rdl4,0,rdl5);
    Rego2 D4(clk,InstructionTypel4,0,InstructionTypel5);
    Rego32 D5(clk,Output_l4,0,writedata);

    wb_stage g(clk,opcodel5,InstructionTypel5,rdl5,rtl5,writedata,write_material1,write_address,write,write_material);


endmodule