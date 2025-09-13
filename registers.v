module Rego32(input clk,input [31:0] in,input stall,output reg [31:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule
module Rego6(input clk,input [5:0] in,input stall,output reg [5:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule
module Rego5(input clk,input [4:0] in,input stall,output reg [4:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule
module Rego15(input clk,input [14:0] in,input stall,output reg [14:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule
module Rego26(input clk,input [25:0] in,input stall,output reg [25:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule
module Rego2(input clk,input [1:0] in,input stall,output reg [1:0] out);
always @(posedge clk ) begin
    out <=stall ?  out:in;
end
endmodule