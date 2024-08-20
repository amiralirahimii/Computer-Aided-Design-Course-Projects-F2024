module MaxnetTB();
	reg clk=0,rst=0,start=0;
	reg [31:0] X1=32'b 0_01111100_10011001100110011001101;
	reg [31:0] X2=32'b 0_01111101_10011001100110011001101;
	reg [31:0] X3=32'b 0_01111110_00110011001100110011010;
	reg [31:0] X4=32'b 0_01111110_10011001100110011001101;
	wire [31:0] result;
	wire done;

	Maxnet myMaxNet(.clk(clk), .rst(rst), .start(start), .X1(X1),
		.X2(X2), .X3(X3), .X4(X4), .done(done),
		.result(result));

	always #20 clk=~clk;
	initial begin 
		#40 start=1'b1;
		#20 start=1'b0;
		#10000
		$stop;
	end
endmodule