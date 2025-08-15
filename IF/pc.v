module programCounter (
    input clk,
    input stall,
    input [31:0]Next_pc,
    input jump_cs,
    output reg [31:0]pc_curr  // ye chahiye baad ke liye
    

);
    //reg pc_past;
    initial begin
        pc_curr=0;
    end
    always @(posedge clk)
        begin
            if (stall)  pc_curr=pc_curr;
            else
                begin
                    if(jump_cs) pc_curr=Next_pc;
                    else    pc_curr=pc_curr+1;
                end
            //pc_past=pc_curr;
        end
  
endmodule