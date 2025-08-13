module instructionRegister(
    input clk,
    input [31:0]pc,
    output reg [31:0]instruction
);
    reg [31:0] Instruction_Register [15:0];
    integer i;
    initial begin
        //read from a mem file
    end
    always @(posedge clk ) begin
        instruction = Instruction_Register[pc];
    end
endmodule