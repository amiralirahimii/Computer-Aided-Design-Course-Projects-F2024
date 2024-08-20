module MUX2x1(i0, i1, sel, out);
	input[31:0] i0, i1;
	input sel;
	output[31:0] out;
	assign out = (sel==1'b0) ? i0 :
			(sel==1'b1) ? i1 : 32'bx;
endmodule
