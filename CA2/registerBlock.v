module  registerBlock #(parameter N = 5) (clk, rst, en, In0, In1, In2, In3, Out0, Out1, Out2, Out3);
	input clk, rst, en;
	input [N-1:0] In0, In1, In2, In3;
	output [N-1:0] Out0, Out1, Out2, Out3;
    register #N  REG_1(.clk(clk),.rst(rst),.en(en),.in(In0),.out(Out0));
    register #N  REG_2(.clk(clk),.rst(rst),.en(en),.in(In1),.out(Out1));
    register #N  REG_3(.clk(clk),.rst(rst),.en(en),.in(In2),.out(Out2));
    register #N  REG_4(.clk(clk),.rst(rst),.en(en),.in(In3),.out(Out3));
endmodule