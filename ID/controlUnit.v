module controlUnit(
    input clk,
    input [31:0]instruction,
    output [5:0]opcode
);
    reg [1:0] InstructionType;
    parameter R=2'd0, J=2'd1, HALT=2'd2, I=2'd3;
    always @(posedge clk ) begin
        case(opcode)
            6'b000000:  InstructionType=R;
            6'b000010:  InstructionType=J;
            6'b111111:  InstructionType=HALT;
            default:    InstructionType=I;
        endcase
    end
endmodule