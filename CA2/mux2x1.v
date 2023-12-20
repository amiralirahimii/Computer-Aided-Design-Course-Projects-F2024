module mux2x1(in0, in1, sel, out);
	input[31:0] in0, in1;
	input sel;
	output[31:0] out;
    C2 #32 C2_MUX_2x1(.D00(in0), .D01(in1), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(sel), .B0(1'b1), .out(out));
endmodule