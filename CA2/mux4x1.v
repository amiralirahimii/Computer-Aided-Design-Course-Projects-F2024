module mux4x1(in0, in1, in2, in3, sel, out);
	input[31:0] in0, in1, in2, in3;
	input[1:0] sel;
	output [31:0] out;
    C2 #32 C2_MUX_4x1(.D00(in0), .D01(in1), .D10(in2), .D11(in3), .A1(sel[1]), .B1(1'b0), .A0(sel[0]), .B0(1'b1), .out(out));
endmodule
