module MaxnetTB();
	reg clk=0,rst=0,start=0;
	reg [4:0] X1=32'b 00010;
	reg [4:0] X2=32'b 00111;
	reg [4:0] X3=32'b 00001;
	reg [4:0] X4=32'b 00110;
	wire [4:0] result;
	wire done;

	Maxnet myMaxNet(.clk(clk), .rst(rst), .start(start), .X1(X1),
		.X2(X2), .X3(X3), .X4(X4), .done(done),
		.result(result));

	always #20 clk=~clk;
	initial begin
		#30 rst=1'b1;
		#30 rst=1'b0;
		#50 start=1'b1;
		#50 start=1'b0;
		#10000
		$stop;
	end
endmodule