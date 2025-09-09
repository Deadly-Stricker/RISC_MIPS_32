module ALU(
    input clk,
    input [5:0]opcode,
    input [31:0]SRC,
    input [31:0]TARG,
    input [31:0] immediateVal,
    input [5:0] funct,
    input [4:0] shamt,
    input [31:0] pc,
    input [31:0] inpc,
    // input [31:0] immed,
    output reg [31:0] Outp
);
    reg [31:0] prev_out;
    always @(*) begin
        case(opcode)
            6'b000000:  
                begin
                    case(funct)
                        6'b100000:  Outp <= SRC + TARG; // add
                        6'b100010:  Outp <= SRC - TARG; // subtract
                        6'b100100:  Outp <= SRC & TARG; // and
                        6'b100101:  Outp <= SRC | TARG; // or
                        6'b100110:  Outp <= SRC ^ TARG;   // xor
                        6'b101010:  Outp <= (SRC < TARG);   //less than
                        6'b000000:  Outp <= TARG << shamt;  //left shift
                        6'b000010:  Outp <= TARG >> shamt;  //right shift
                    endcase
                end
            6'b000010:  
                begin
                    Outp <= inpc;
                end 
            6'b001000:  Outp <= SRC + immediateVal;
            6'b001100:  Outp <= SRC & immediateVal;
            6'b100011:  Outp <= SRC + immediateVal; // LW
            6'b101011:  Outp <= SRC + immediateVal; // SW
            6'b000100:  Outp <= SRC==TARG ? pc + immediateVal << 2 : 0;
            6'b000101:  Outp <= SRC!=TARG ? pc + immediateVal << 2 : 0; 
        endcase
    end
endmodule