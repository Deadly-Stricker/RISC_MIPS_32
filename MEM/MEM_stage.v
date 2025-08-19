module MEM_stage(
    input clk,
    input [5:0] opcode,
    input [4:0] Rt, //rt adress
    input [31:0] Rt_value,
    input [31:0] effictiveaddr,
    // input [31:0] write_stuff,
    output reg [31:0] op_mem,  //can be write material for register file fo sw
    output reg write_reg,
    output reg [4:0] Rt_address
);
    reg write,read;
    wire [31:0] outp_of_mem;
    reg [31:0] write_stuff,addrRead,addrWrite;
    MemoryD RAMmem(addrRead,addrWrite,clk,write,read,write_stuff,outp_of_mem);
    always @(*) begin
        case (opcode)
            6'b100011: // lw
                begin
                    write_reg <= 1; // to register to start writing
                    addrRead <= effictiveaddr; // giving effective address to memory
                    read<=1; // for the memory to start reading
                    op_mem <= outp_of_mem; //write material
                    Rt_address <= Rt; // addrssw
                end

            6'b101011: // sw
                begin
                    write<=1;
                    addrWrite<=effictiveaddr;
                    write_stuff <= Rt_value;
                end
            default: 
                begin
                    write <= 0;
                    write_reg <= 0;
                    read <= 0;
                    // write = 0;
                end
        endcase
    end

endmodule