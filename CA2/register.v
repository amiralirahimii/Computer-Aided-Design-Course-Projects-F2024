module register #(parameter N = 5) (clk, rst, en, in, out);
	input clk, rst, en;
	input[N-1:0] in;
	output reg[N-1:0] out;
    S2 #N S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule