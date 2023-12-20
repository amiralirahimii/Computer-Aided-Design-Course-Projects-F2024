module reg32(clk, rst, en, in, out);
	input clk, rst, en;
	input[31:0] in;
	output reg[31:0] out;
    S2 #32 S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule