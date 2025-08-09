module datapath(
    input clk1,
    input clk2,
    input clk,
);
    wire stall,jump_cs;
    wire [31:0] instruction,next_pc;
    reg [31:0] out1A;
    IF_stage a(clk,stall,next_pc,jump_cs,instruction);
    Rego A(clk1,instruction,out1A);
    ID_stage b(clk,out1A);


endmodule