module dataPath(clk, sel, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,en7,en9,en11,en5,en12,en10,en8, X,Y,Z, en2,en1,en4, cout3,cout6,cout7,cout9,cout11,cout5,cout8);
	input clk, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,en7,en9,en11,en5,en12,en10,en8;
	input [1:0] sel;
	input [6:0] X,Y,Z;
	wire [1:0] addY;
	wire [5:0] addX,addZ;
	input [15:0] en2,en1,en4; 
	wire [7:0] buffer16Out [0:15];
	wire [7:0] buffer4_1Out [0:15];
	wire [7:0] buffer4_2Out [0:15];
	wire [6:0] sumX,sumY,sumZ;
	wire [3:0] counterOut;
	wire [7:0] macOut;
	wire [7:0] mac1Input,mac2Input;
	output cout3,cout6,cout7,cout9,cout11,cout5,cout8;
	wire [1:0] shiftNum,shiftRegCount;
	wire [3:0] index;
	wire [6:0] muxOut;
	wire [7:0] shiftRegOut[3:0];
	wire [7:0] memOut[3:0];

	mux3to1		mux3(.sel(sel),.a(sumX),.b(sumY),.c(sumZ),.out(muxOut));
	memory		myMem(.clk(clk),.address(muxOut),.wrData(shiftRegOut),.wr(wr),.rdData(memOut));
	counter4	myCounter(.clk(clk),.rst(rst11),.en(en11),.cout(cout11),.count(shiftNum));

	counter64	xCounter(.clk(clk),.rst(rst6),.en(en6),.cout(cout6),.count(addX));
	counter43	zCounter(.clk(clk),.rst(rst7),.en(en7),.cout(cout7),.count(addZ));
	counter4	yCounter(.clk(clk),.rst(rst9),.en(en9),.cout(cout9),.count(addY));
	
	counter16	myCounter3(.clk(clk),.rst(rst5),.en(en5),.cout(cout5),.count(counterOut));
	mac		myMAC(.a(mac1Input),.b(mac2Input),.en(en12),.rst(rst12),.clk(clk),.out(macOut));
	shiftRegister	shiftRegister(.clk(clk),.en(en10),.dataIn(macOut),.dataOut(shiftRegOut));
	counter4	myCounter4(.clk(clk),.rst(rst8),.en(en8),.cout(cout8),.count(shiftRegCount));
	
	mux16to1	mux1(.sel(counterOut),.in(buffer4_1Out),.out(mac1Input));
	mux16to1	mux2(.sel(counterOut),.in(buffer4_2Out),.out(mac2Input));

	buffer4x16	bigBuff(.clk(clk),.shift(shift),.en(en2),.dataIn(memOut),.readIdx(index),.dataOut(buffer16Out));
	filterBuffer	smallBuff2(.clk(clk),.dataIn(memOut),.en(en1),.dataOut(buffer4_1Out));
	counter13	myCounter2(.clk(clk),.rst(rst3),.en(en3),.cout(cout3),.count(index));
	buffer4x4	smallBuff(.clk(clk),.dataIn(buffer16Out),.en(en4),.dataOut(buffer4_2Out));
	
	assign sumX=addX+X;
	assign sumY=addY+Y;
	assign sumZ=addZ+Z;
endmodule