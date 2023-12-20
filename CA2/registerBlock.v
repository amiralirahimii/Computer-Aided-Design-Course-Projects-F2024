module  registerBlock #(parameter N = 5) (clk, rst, en, In0, In1, In2, In3, Out0, Out1, Out2, Out3);
	input clk, rst, en;
	input[N-1:0] In0, In1, In2, In3;
	output reg[N-1:0] Out0, Out1, Out2, Out3;
    register #N  REG_1(.clk(clk),.rst(rst),.en(en),.in(in1),.out(out1));
    register #N  REG_2(.clk(clk),.rst(rst),.en(en),.in(in2),.out(out2));
    register #N  REG_3(.clk(clk),.rst(rst),.en(en),.in(in3),.out(out3));
    register #N  REG_4(.clk(clk),.rst(rst),.en(en),.in(in4),.out(out4));
endmodule