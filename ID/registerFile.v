module registerFile(
    input [4:0] addrss,
    input clk,
    output reg [31:0] Outp
);
    reg [31:0] Register_File [31:0];
    always @(posedge clk ) begin
        Outp <= Register_File[addrss];
    end

endmodule