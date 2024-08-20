module dataPath #(parameter N) (clk, sel,done, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,
en7,en9,en11,en5,en12,en10,en8, X,Y,Z, en2,en1,en4, cout3,cout6,cout7,cout9,cout11,cout5,cout8,
rst6_2,rst9_2,rst13,rst14,rst5_2,rst7_2,rst12_2,rst8_2,en6_2,en9_2,en13,en14,en5_2,en2_2,en4_2,en7_2,en12_2,en10_2,en8_2,
wr2,done_2,sel_2,en1_2,addX_2,addY_2,sumX_2,sumY_2,cout6_2,cout9_2,cout13,cout14,cout5_2,cout7_2,cout3_2);


	input clk, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,en7,en9,en11,en5,en12,en10,en8;
	input sel, done;
	input [6:0] X,Y,Z;
	wire [31:0] addY,addX,addZ;
	input [15:0] en2,en4;
	input [15:0] en1 [0:N-1];  
	wire [7:0] buffer16Out [0:15];
	wire [7:0] buffer4_2Out [0:15];
   	wire [31:0] sumX,sumY,sumZ;
	wire [3:0] counterOut;
	wire [7:0] mac2Input;
	output cout3,cout6,cout7,cout9,cout11,cout5,cout8;
	wire [3:0] index;
	wire [31:0] muxOut;
	wire [7:0] memOut[3:0];



	mux2to1		mux1(.sel(sel),.a(sumX),.b(sumY),.out(muxOut));
	memory		myMem(.clk(clk),.address(muxOut),.wrData(),.wr(),.rdData(memOut));
	counter4	myCounter(.clk(clk),.rst(rst11),.en(en11),.cout(cout11),.count());

	counter64	xCounter(.clk(clk),.rst(rst6),.en(en6),.cout(cout6),.count(addX));
	counter43	zCounter(.clk(clk),.rst(rst7),.en(en7),.cout(cout7),.count(addZ));
	kernelCounter #(4*N) yCounter(.clk(clk),.rst(rst9),.en(en9),.count(addY),.cout(cout9));

	counter16	myCounter3(.clk(clk),.rst(rst5),.en(en5),.cout(cout5),.count(counterOut));

	mux16to1	mux2(.sel(counterOut),.in(buffer4_2Out),.out(mac2Input));

	buffer4x16	bigBuff(.clk(clk),.shift(shift),.en(en2),.dataIn(memOut),.readIdx(index),.dataOut(buffer16Out));
	counter13	myCounter2(.clk(clk),.rst(rst3),.en(en3),.cout(cout3),.count(index));
	buffer4x4	smallBuff(.clk(clk),.dataIn(buffer16Out),.en(en4),.dataOut(buffer4_2Out));

	wire[31:0] muxOut_2;
	wire[7:0] memOut_2 [0:3][0:3];
	genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
			wire[7:0] shiftReg[0:3];
			PE pe(.clk(clk),.bufferInput(memOut),.en1(en1[i]),.sel(counterOut),.mac2Input(mac2Input),
			.en2(en12),.rst2(rst12),.en3(en10),.en4(en8),.rst4(rst8),.cout4(cout8),
			.shiftRegOut(shiftReg));
			OFM #(i) ofm(.clk(clk),.address(sumZ),.rdAdress(muxOut_2),.wrData(shiftReg),.wr(wr),.done(done),.rdData(memOut_2[i]));
        end
    endgenerate

	assign sumX=addX+X;
	assign sumY=addY+Y;
	assign sumZ=addZ+Z;

	//dataPath2

	input rst6_2,rst9_2,rst13,rst14,rst5_2,rst7_2,rst12_2,rst8_2;
	input en6_2,en9_2,en13,en14,en5_2,en2_2,en7_2,en12_2,en10_2,en8_2;
	input wr2;
	input done_2;
	input sel_2;
	input [15:0] en4_2;
	input [15:0] en1_2 [0:3];
	output cout6_2,cout9_2,cout13,cout14,cout5_2,cout7_2,cout3_2;
	input [31:0] addX_2,addY_2;
	input [31:0] sumX_2,sumY_2;
	
	wire [31:0] ofm_addr;
	wire[3:0] k, q;
	wire[7:0] mac2Input_2[0:3];
	wire[3:0] muxSelect;	


	counter43	xCounter_2(.clk(clk),.rst(rst6_2),.en(en6_2),.cout(cout6_2),.count(addX_2));
	kernelCounter #(16) yCounter_2(.clk(clk),.rst(rst9_2),.en(en9_2),.count(addY_2),.cout(cout9_2));

	assign sumX_2 = addX_2 + Z;
	assign sumY_2 = addY_2 + 0;
	mux2to1		mux2_1(.sel(sel_2),.a(sumX_2),.b(sumY_2),.out(muxOut_2));


	counter10	counter10_1(.clk(clk), .rst(rst13), .en(en13), .cout(cout13), .count(k));
	counter10	counter10_2(.clk(clk), .rst(rst14), .en(en14), .cout(cout14), .count(q));
	counter16	counter16_2(.clk(clk), .rst(rst5_2), .en(en5_2), .cout(cout5_2), .count(muxSelect));

	genvar j;
    generate
        for (j = 0; j < 4; j = j + 1)
        begin
			wire[7:0] buffer13_Out[0:15];
			buffer13x13	buff13(.clk(clk),.en(en2_2),.dataIn(memOut_2[j]),.address(addX_2),.k(k),.q(q),
			.dataOut(buffer13_Out));
			wire [7:0] buffer4_2Out_2 [0:15];
			buffer4x4	buff4(.clk(clk),.dataIn(buffer13_Out),.en(en4_2),.dataOut(buffer4_2Out_2));
			mux16to1	mux2_2(.sel(muxSelect),.in(buffer4_2Out_2),.out(mac2Input_2[j]));
        end
    endgenerate

	counter25		counter25(.clk(clk),.rst(rst7_2),.en(en7_2),.cout(cout7_2),.count(ofm_addr));

	genvar j2;
    generate
        for (j2 = 0; j2 < 4; j2 = j2 + 1)
        begin
			wire [7:0] ofm2_in [0:3];
			PE2		pe2(.clk(clk),.sel(muxSelect),.en0(en12_2),.en1(en1_2),.en2(en10_2),.en3(en8_2),
			.rst0(rst12_2),.rst3(rst8_2),.mac2Input(mac2Input_2),.bufferInput(memOut_2[j2]),.cout3(cout3_2),.shiftRegOut(ofm2_in));
			OFM2	#(j2) ofm_2(.clk(clk),.address(ofm_addr),.wrData(ofm2_in),.wr(wr2),.done(done_2));
        end
    endgenerate
	
endmodule