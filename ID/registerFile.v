module registerFile(
    input [4:0] addrss1,
    input [4:0] addrss2,
    input [4:0] addrssw,
    input clk,
    // input read1,
    // input read2,
    input write,
    input [31:0] write_material,
    output [31:0] Outp1,
    output [31:0] Outp2
);
    reg [31:0] Register_File [31:0];
    initial begin
        for(i=0;i<16;i++)
            begin
                Register_File[i]=i;
            end
    end
    always @(posedge clk ) begin
        // if(read1)   Outp1 <= Register_File[addrss1];
        // if(read2)   Outp2 <= Register_File[addrss2];
        
        if(write)  Register_File[addrssw]=write_material;    
    end
    assign Outp1 = Register_File[addrss1];
    assign Outp2 = Register_File[addrss2];
endmodule