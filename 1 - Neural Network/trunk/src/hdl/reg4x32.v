module reg4x32(clk, rst, en, In0, In1, In2, In3, Out0, Out1, Out2, Out3);
	input clk, rst, en;
	input[31:0] In0, In1, In2, In3;
	output reg[31:0] Out0, Out1, Out2, Out3;
	always@(posedge clk)
	begin
		if(rst)
			{Out0, Out1, Out2, Out3} <= 128'b0;
		else if(en)
			{Out0, Out1, Out2, Out3} <= {In0, In1, In2, In3};
		else
			{Out0, Out1, Out2, Out3} <= {Out0, Out1, Out2, Out3};
	end
endmodule
