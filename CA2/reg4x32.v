module reg4x32(clk, rst, en, In0, In1, In2, In3, Out0, Out1, Out2, Out3);
	input clk, rst, en;
	input[31:0] In0, In1, In2, In3;
	output reg[31:0] Out0, Out1, Out2, Out3;
    reg32   REG32_1(.clk(clk),.rst(rst),.en(en),.in(in1),.out(out1));
    reg32   REG32_2(.clk(clk),.rst(rst),.en(en),.in(in2),.out(out2));
    reg32   REG32_3(.clk(clk),.rst(rst),.en(en),.in(in3),.out(out3));
    reg32   REG32_4(.clk(clk),.rst(rst),.en(en),.in(in4),.out(out4));
endmodule