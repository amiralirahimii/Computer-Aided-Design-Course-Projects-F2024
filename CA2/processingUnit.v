module processingUnit(clk, rst, enReg, A1, W1, A2, W2, A3, W3, A4, W4, result);
	input clk, rst, enReg;
	input[4:0] A1, W1, A2, W2, A3, W3, A4, W4;
	output[4:0] result;
	
	wire[9:0] MulA1W1, MulA2W2, MulA3W3, MulA4W4;
	wire[9:0] regMulA1W1, regMulA2W2, regMulA3W3, regMulA4W4;
	wire[10:0] A1W1AddA2W2, A3W3AddA4W4;
	wire[11:0] addAll;
	wire sign;

	multiplier MUL1(.A(A1), .B(W1), .out(MulA1W1));
	multiplier MUL2(.A(A2), .B(W2), .out(MulA2W2));
	multiplier MUL3(.A(A3), .B(W3), .out(MulA3W3));
	multiplier MUL4(.A(A4), .B(W4), .out(MulA4W4));

	registerBlock #10 RB1(.clk(clk), .rst(rst),
		.en(enReg), .In0(MulA1W1),
		.In1(MulA2W2), .In2(MulA3W3),
		.In3(MulA4W4), .Out0(regMulA1W1),
		.Out1(regMulA2W2), .Out2(regMulA3W3),
		.Out3(regMulA4W4));

	adder #10 a1(regMulA1W1,regMulA2W2,clk,A1W1AddA2W2);
	adder #10 a2(regMulA3W3,regMulA4W4,clk,A3W3AddA4W4);
	adder #11 a3(A1W1AddA2W2,A3W3AddA4W4,clk,addAll);

	assign sign = addAll[11];
	MUX2x1 mux2x1(.in0({sign, addAll[6:3]}), .in1(5'b0), .sel(sign), .out(result));
endmodule
