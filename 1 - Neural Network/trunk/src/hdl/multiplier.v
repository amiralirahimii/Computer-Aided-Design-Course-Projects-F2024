module multiplier(A, B, out);
	input[31:0] A, B;
	output[31:0] out;

	wire[22:0] AMantissa, BMantissa;
	wire[23:0] AValue, BValue;
	wire[7:0] AExp, BExp;
	wire ASign, BSign;

	wire[47:0] bigMantissa;
	wire[22:0] mantissa;
	wire[7:0] exp;
	wire sign;
	wire AZero, BZero;	
	assign AZero = ~|A[30:0];	
	assign BZero = ~|B[30:0];

	assign {ASign, AExp, AMantissa} = A;
	assign AValue = {1'b1, AMantissa};
	assign {BSign, BExp, BMantissa} = B;
	assign BValue = {1'b1, BMantissa};

	assign bigMantissa = AValue * BValue;
	assign exp = (bigMantissa[47]) ? AExp+BExp-126 : AExp+BExp-127;
	assign mantissa = (bigMantissa[47]) ? bigMantissa[46:24] : bigMantissa[45:23];
	assign sign = ASign ^ BSign;

	assign out = (AZero | BZero) ? 32'b0 : {sign, exp, mantissa};
endmodule