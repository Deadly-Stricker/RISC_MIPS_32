module wb_stage(
    input clk,
    input [5:0] opcode,
    input [1:0]Instruction_type,
    input [4:0] rd_add,
    input [4:0] rt_add,
    input [31:0] write_data,
    output reg [4:0] writing_address,
    output reg write,
    output reg [31:0] write_inp 
);
always @(posedge clk ) begin
    case(Instruction_type)
        2'b00:
            begin
                writing_address <= rd_add;
                write <=1;
                write_inp <= write_data;
            end

        2'b11:
            begin
                if(opcode != 6'b101011)
                    begin
                        writing_address <= rt_add;
                        write <= 1;
                    end
            end

    endcase
    
end
endmodule