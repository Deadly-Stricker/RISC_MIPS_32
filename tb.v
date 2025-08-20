module testb;
    reg clk,clk2,clk3;
    wire [31:0] out;
    datapath UUT(clk,clk2,clk3,out);
    initial begin
        clk=0;
        clk2=0;
        clk3=0;
        #200 
        // $writememh("MEM/content_mem.mem",Memory_File);
        $finish;
    end
    always  begin
        #3  clk=~clk;
    end
    always  begin
        #5  clk2=1;
        #5  clk2=0;
        #5  clk3=1;
        #5  clk3=0;
    end
    always@(posedge clk)  
        begin
            // $display("%d : %h : %h : %h : %h",$time,UUT.instruction,out,UUT.Rs,UUT.Rt);
            $display("%d :  %h : %d : %h",$time,UUT.instruction, UUT.opcodel4, UUT.write_address, UUT.write_material);

        end
endmodule
