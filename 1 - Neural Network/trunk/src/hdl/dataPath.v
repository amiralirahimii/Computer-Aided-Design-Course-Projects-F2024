module dataPath(clk, rst, X1, X2, X3, X4, sel, en0, en1, en2, en3, complete, result);
	input clk, rst;
	input[31:0] X1, X2, X3, X4;
	input sel, en0, en1, en2, en3;
	output complete;
	output [31:0]result;
	wire[31:0] lastMuxOut;
	wire[31:0] W[0:15];
	wire[31:0] a1Init, a2Init, a3Init, a4Init;
	wire[31:0] a1, a2, a3, a4;
	wire[31:0] a1New, a2New, a3New, a4New;
	wire[31:0] a1NewA, a2NewA, a3NewA, a4NewA;
	wire[1:0] idx;
	
	MUX2x1 MUX1(.i0(a1New), .i1(a1Init), .sel(sel), .out(a1));
	MUX2x1 MUX2(.i0(a2New), .i1(a2Init), .sel(sel), .out(a2));
	MUX2x1 MUX3(.i0(a3New), .i1(a3Init), .sel(sel), .out(a3));
	MUX2x1 MUX4(.i0(a4New), .i1(a4Init), .sel(sel), .out(a4));
	
	buffer16x32 WBuffer(.out(W));

	processingUnit PU1(.clk(clk), .rst(rst), .enReg(en1), .A1(a1),
			.W1(W[0]), .A2(a2), .W2(W[1]), .A3(a3),
			.W3(W[2]), .A4(a4), .W4(W[3]), .result(a1NewA));

	processingUnit PU2(.clk(clk), .rst(rst), .enReg(en1), .A1(a1),
			.W1(W[4]), .A2(a2), .W2(W[5]), .A3(a3),
			.W3(W[6]), .A4(a4), .W4(W[7]), .result(a2NewA));

	processingUnit PU3(.clk(clk), .rst(rst), .enReg(en1), .A1(a1),
			.W1(W[8]), .A2(a2), .W2(W[9]), .A3(a3),
			.W3(W[10]), .A4(a4), .W4(W[11]), .result(a3NewA));

	processingUnit PU4(.clk(clk), .rst(rst), .enReg(en1), .A1(a1),
			.W1(W[12]), .A2(a2), .W2(W[13]), .A3(a3),
			.W3(W[14]), .A4(a4), .W4(W[15]), .result(a4NewA));
	
	reg4x32 AReg(.clk(clk), .rst(rst), .en(en2), .In0(a1NewA),
		.In1(a2NewA), .In2(a3NewA), .In3(a4NewA), .Out0(a1New),
		.Out1(a2New), .Out2(a3New), .Out3(a4New));

	decoder myDCD(.A1(a1New), .A2(a2New), .A3(a3New), .A4(a4New),
			.idx(idx), .done(complete));

	reg4x32 XReg(.clk(clk), .rst(rst), .en(en0), .In0(X1),
			.In1(X2), .In2(X3), .In3(X4), .Out0(a1Init),
			.Out1(a2Init), .Out2(a3Init), .Out3(a4Init));

	MUX4x1 MUX5(.i0(a1Init), .i1(a2Init), .i2(a3Init), .i3(a4Init),
		.sel(idx), .out(lastMuxOut));

	reg32 FinalReg(.clk(clk), .rst(rst), .en(en3), .in(lastMuxOut), .out(result));
endmodule
