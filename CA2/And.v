module And(a,b,out);
input a,b;
output out;
C1 C1_AND(.A0(1'b0),.A1(a),.SA(b),.B0(),.B1(),.SB(),.S0(1'b0),.S1(1'b0),.F(out));
endmodule