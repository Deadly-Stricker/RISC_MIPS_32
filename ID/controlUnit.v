module controlUnit(
    input clk,
    input [5:0]opcode,
    input [4:0] rt,   // target resiter
    input [4:0] rs,   // source register
    input [4:0] rd,   // destination rergister
    input [4:0] sa,   // kitna shift krna h wo 
    input [5:0] funct, // defines which function it implements
    input [5:0] instr_address,
    input [14:0] Adress_Immediate,
    input [1:0] InstructionType
    output read,
    output write
);
    always @(posedge clk ) begin
        case(InstructionType)
            R:  
                begin
                    
                end
            I:  
                begin

                end
            J:
                begin
                    
                end
        endcase
    end
endmodule