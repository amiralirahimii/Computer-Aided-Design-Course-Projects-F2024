module buffer16x32(out);
	parameter[31:0] ONE = 32'b0011_1111_1000_0000_0000_0000_0000_0000, MINUSEPSILON = 32'b1011_1110_0100_1100_1100_1100_1100_1101;
	output reg[31:0] out[0:15];
	initial begin
		out[0] = ONE;
		out[1] = MINUSEPSILON;
		out[2] = MINUSEPSILON;
		out[3] = MINUSEPSILON;
		out[4] = MINUSEPSILON;
		out[5] = ONE;
		out[6] = MINUSEPSILON;
		out[7] = MINUSEPSILON;
		out[8] = MINUSEPSILON;
		out[9] = MINUSEPSILON;
		out[10] = ONE;
		out[11] = MINUSEPSILON;
		out[12] = MINUSEPSILON;
		out[13] = MINUSEPSILON;
		out[14] = MINUSEPSILON;
		out[15] = ONE;
	end
endmodule
