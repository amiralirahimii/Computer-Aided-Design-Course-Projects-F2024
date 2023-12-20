module Maxnet(clk, rst, start, X1, X2, X3, X4, done, result);
	input clk, rst, start;
	input[4:0]X1, X2, X3, X4;
	output done;
	output[4:0] result;
	wire sel, en0, en1, en2, en3, complete;
	
	dataPath DP(.clk(clk), .rst(rst), .X1(X1), .X2(X2),
		.X3(X3), .X4(X4), .sel(sel), .en0(en0),
		.en1(en1), .en2(en2), .en3(en3), .complete(complete),
		.result(result));

	controller CU(.clk(clk), .start(start), .complete(complete), .sel(sel),
		.en0(en0), .en1(en1), .en2(en2), .en3(en3),
		.done(done));
endmodule


