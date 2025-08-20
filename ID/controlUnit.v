module controlUnit(
    input clk,
    input [5:0]opcode,
    input [4:0] rt,   // target resiter
    input [4:0] rs,   // source register
    input [4:0] rd,   // destination rergister
    input [4:0] sa,   // kitna shift krna h wo //shift amount
    input [5:0] funct, // defines which function it implements
    input [25:0] instr_address,
    input [15:0] Adress_Immediate,
    input [1:0] InstructionType,
    input [31:0] pc,
    output reg [4:0]readadd1,
    output reg [4:0]readadd2,
    ///output reg write,
    output reg [31:0] immed,
    output reg [31:0] outpc
);
parameter R=2'd0, J=2'd1, HALT=2'd2, I=2'd3;
    always @(* ) begin
        case(InstructionType)
            R:  
                begin
                    readadd1 <= rs;
                    readadd2 <= rd;
                end
            I:  
                begin
                    readadd1 <= rs;
                    readadd2 <= rt;
                    immed <= {{16{Adress_Immediate[15]}},Adress_Immediate}; // sign extention
                    // immed <= 32'b1; // sign extention
                end
            J:
                begin
                    outpc <= {pc[31:26],instr_address};
                end
        endcase
    end
endmodule