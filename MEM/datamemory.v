module MemoryD(
    input [31:0] addrss1,
    input [31:0] addrssw,
    input clk,
    input write,
    input read,
    input [31:0] write_material,
    output reg [31:0] Outp1
);
    reg [31:0] Memory_File [31:0];
    initial begin
        // read into the memory file through mem file
        $readmemh("MEM/content_mem.mem",Memory_File);

    end
    always @(posedge clk ) begin
        
        if(write)  Memory_File[addrssw]=write_material;  
        if(read)    Outp1 = Memory_File[addrss1];
    end
    // assign Outp1 = Memory_File[addrss1];
endmodule