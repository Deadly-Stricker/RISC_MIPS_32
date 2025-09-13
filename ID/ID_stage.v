// module ID_stage(
//     input clk,
//     input [31:0]instruction,
//     input [4:0] addrss,
//     input read,
//     input write,
//     input [31:0] write_material,
//     output reg [5:0]opcode,
//     output reg [4:0]rt,   // target resiter
//     output reg [4:0]rs,   // source register
//     output reg [4:0]rd,   // destination rergister
//     output reg [4:0]sa,   // kitna shift krna h wo 
//     output reg [5:0]funct, // defines which function it implements
//     output reg [5:0]instr_address,
//     output reg [14:0] Adress_Immediate,
//     output reg [31:0] Outp
// );
//     controlUnit CU(.clk(clk),.instruction(instruction),.opcode(opcode),.rt(rt),.rs(rs),.rd(rd),.sa(sa),.funct(funct),.instr_address(instr_address),.Adress_Immediate(Adress_Immediate));
//     registerFile RF(.addrss(addrss),.clk(clk),.read(read),.write(write),.write_material(write_material),.Outp(Outp));
// endmodule



module ID_stage(
    input clk,
    input [4:0] pvrd,
    input [31:0]instruction,
    output reg [5:0]opcode,
    output reg [4:0] rt,   // target resiter
    output reg [4:0] rs,   // source register
    output reg [4:0] rd,   // destination rergister
    output reg [4:0] sa,   // kitna shift krna h wo 
    output reg [5:0] funct, // defines which function it implements   // goes as it is to alu
    output reg [25:0] instr_address,
    output reg [15:0] Adress_Immediate,
    output reg [1:0] InstructionType,
    output reg stall
    // output reg [4:0] prev_regd    // i am declaring it here in effort to use it later to check if the rt or rs in next instruction is rd in previous instruction this way we can do the operand forwarding
);
    reg [31:0] source_register;   // value that we will get from Register file thorugh ControlUnit
    

    // registerFile RF(.addrss(),.clk(clk),.read(),.write(),.write_material(),.Outp());
    // reg [1:0] InstructionType;
    parameter R=2'd0, J=2'd1, HALT=2'd2, I=2'd3;
    always @(* ) begin
        // stall=1;
        opcode = instruction[31:26];
        case(opcode)
            6'b000000:  InstructionType<=R;
            6'b000010:  InstructionType<=J;
            6'b111111:  InstructionType<=HALT;
            6'b001000,6'b001100,6'b100011,6'b101011,6'b000100,6'b000101:    InstructionType<=I;
        endcase
    // end

    // always @(InstructionType) // merged 2 always to one always to reduce ambiguity
    // begin
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
                    rs<=instruction[25:21];
                    rt<=instruction[20:16];
                    Adress_Immediate<=instruction[15:0];
                end
        endcase
        // if(rt == pvrd || rs == pvrd)  stall<=1;
        // else
        //     begin
        //         stall<=0;
        //         prev_regd <= instruction[15:11];
        //     end
        stall = (rt == pvrd || rs == pvrd);
    end

endmodule