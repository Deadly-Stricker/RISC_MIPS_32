module registerFile(
    input [4:0] addrss,
    input clk,
    input read,
    input write,
    input [31:0] write_material,
    output reg [31:0] Outp
);
    reg [31:0] Register_File [31:0];
    always @(posedge clk ) begin
        if(read)   Outp <= Register_File[addrss];
        else if(write)  Register_File[addrss]=write_material;    
    end

endmodule