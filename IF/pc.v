module programCounter (
    input clk,
    input stall,
    input [5:0]Next_pc,
    input jump_cs,
    output reg [5:0]pc_curr
);
    //reg pc_past;
    always @(posedge clk)
        begin
            if (stall)  pc_curr=pc_curr;
            else
                begin
                    if(jump_cs) pc_curr=Next_pc;
                    else    pc_curr=pc_curr+4;
                end
            //pc_past=pc_curr;
        end
  
endmodule