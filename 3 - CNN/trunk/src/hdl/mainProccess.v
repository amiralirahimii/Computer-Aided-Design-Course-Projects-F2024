module mainProccess #(parameter N) (clk,start,X,Y,Z,doneOut);
	input clk,start;
	input [6:0] X,Y,Z;	
	wire done;
	output doneOut;
	assign doneOut = done;

	wire rst3,rst5,rst6,rst7,rst8,rst9,rst11,rst12, en3,en5,en6,en7,en8,en9,en10,en11,en12, cout3,cout5,cout6,cout7,cout8,cout9,cout11, wr, shift;
	wire rst6_2,rst9_2,rst13,rst14,rst5_2,rst7_2,rst12_2,rst8_2,en6_2,en9_2,en13,en14,en5_2,en2_2,en7_2,en12_2,en10_2,en8_2,
	wr2,done_2,sel_2,cout6_2,cout9_2,cout13,cout14,cout5_2,cout7_2,cout3_2;
	wire sel;
	wire [15:0] en2,en4,en4_2;
	wire [31:0] addX_2,addY_2,sumX_2,sumY_2;
	wire [15:0] en1 [0:N-1]; 

	wire [15:0] en1_2 [0:3];
	controller #N myController1(.clk(clk),.start(start),.cout3(cout3), .cout5(cout5), .cout6(cout6), .cout7(cout7), .cout8(cout8), .cout9(cout9),
	.cout11(cout11), .en1(en1), .en2(en2), .en3(en3), .en4(en4), .en5(en5), .en6(en6),.en7(en7),.en8(en8),.en9(en9), .en10(en10),
	.en11(en11), .en12(en12), .rst3(rst3),.rst5(rst5), .rst6(rst6), .rst7(rst7), .rst8(rst8), .rst9(rst9), .rst11(rst11), .rst12(rst12),
	.sel(sel), .shift(shift), .wr(wr), .done(done));

	controller2   myController2(.clk(clk), .done(done), .cout6_2(cout6_2), .cout14(cout14), .cout5_2(cout5_2), .cout7_2(cout7_2),.cout3_2(cout3_2) ,.en1_2(en1_2), 
	.en9_2(en9_2), .sel_2(sel_2), .en2_2(en2_2), .en6_2(en6_2), .en14(en14), .en4_2(en4_2), .en5_2(en5_2), .en12_2(en12_2), .en13(en13), .en10_2(en10_2),
	.en8_2(en8_2), .en7_2(en7_2), .wr2(wr2),.rst9_2(rst9_2), .rst6_2(rst6_2), .rst13(rst13), .rst14(rst14), .rst7_2(rst7_2), .rst12_2(rst12_2), 
	.rst8_2(rst8_2), .rst5_2(rst5_2), .done_2(done_2));

	dataPath #N myDataPath(.clk(clk),.rst6(rst6),.rst7(rst7),.rst9(rst9),.en6(en6),.en7(en7),.en9(en9),.cout6(cout6),.cout7(cout7),.cout9(cout9),
	.sel(sel),.done(done),.wr(wr),.rst11(rst11),.en11(en11),.cout11(cout11),.shift(shift),.en1(en1),.en2(en2),.en3(en3),.rst3(rst3),.cout3(cout3),
	.en4(en4),.rst5(rst5),.en5(en5),.cout5(cout5),.rst12(rst12),.en12(en12),.en10(en10),.rst8(rst8),.en8(en8), .cout8(cout8),.X(X),.Y(Y),.Z(Z),
	.rst6_2(rst6_2),.rst9_2(rst9_2),.rst13(rst13),.rst14(rst14),.rst5_2(rst5_2),.rst7_2(rst7_2),.rst12_2(rst12_2),.rst8_2(rst8_2),.en6_2(en6_2),
	.en9_2(en9_2),.en13(en13),.en14(en14),.en5_2(en5_2),.en2_2(en2_2),.en4_2(en4_2),.en7_2(en7_2),.en12_2(en12_2),.en10_2(en10_2),.en8_2(en8_2),
	.wr2(wr2),.done_2(done_2),.sel_2(sel_2),.en1_2(en1_2),.addX_2(addX_2),.addY_2(addY_2),.sumX_2(sumX_2),.sumY_2(sumY_2),.cout6_2(cout6_2),
	.cout9_2(cout9_2),.cout13(cout13),.cout14(cout14),.cout5_2(cout5_2),.cout7_2(cout7_2),.cout3_2(cout3_2));
endmodule
