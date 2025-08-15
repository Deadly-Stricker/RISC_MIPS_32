module IF_stage(
    input clk,
    input stall,
    input [31:0]Next_pc,
    input jump_cs,
    output [31:0]instruction,
    output [31:0] outpc
);
    wire [31:0] connector_from_pc_to_IR; 
    
    // reg Instruction_storage;
    programCounter PC_Module (.clk(clk),.stall(stall),.Next_pc(Next_pc),.jump_cs(jump_cs),.pc_curr(connector_from_pc_to_IR));
    instructionRegister IR_Module (.pc(connector_from_pc_to_IR),.instruction(instruction));
    assign outpc = connector_from_pc_to_IR;
endmodule