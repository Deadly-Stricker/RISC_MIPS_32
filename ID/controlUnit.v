module controlUnit(
    input clk,
    input [31:0]instruction,
    output reg [5:0]opcode,
    output [4:0]reg rt,   // target resiter
    output [4:0]reg rs,   // source register
    output [4:0]reg rd,   // destination rergister
    output [4:0]reg sa,   // kitna shift krna h wo 
    output [5:0]reg funct, // defines which function it implements
    output [5:0]reg instr_address,
    output [14:0] Adress_Immediate
);
    reg [1:0] InstructionType;
    parameter R=2'd0, J=2'd1, HALT=2'd2, I=2'd3;
    always @(posedge clk ) begin
        opcode = instruction[31:26];
        case(opcode)
            6'b000000:  InstructionType=R;
            6'b000010:  InstructionType=J;
            6'b111111:  InstructionType=HALT;
            default:    InstructionType=I;
        endcase
    end

    always @(InstructionType) begin
        case(InstructionType)
            R:  
                begin
                    rs<=instruction[25:21];
                    rt<=instruction[20:16];
                    rd<=instruction[15:11];
                    sa<=instruction[10:6];
                    funct<=instruction[5:0];
                end
            J:
                begin
                    instr_address<=instruction[25:0];
                end
            I:  
                begin
                    rs<=instruction[25:0];
                    rt<=instruction[20:16];
                    Adress_Immediate<=[15:0];
                end
        endcase
    end
endmodule