module reg32(clk, rst, en, in, out);
	input clk, rst, en;
	input[31:0] in;
	output reg[31:0] out;
	always@(posedge clk)
	begin
		if(rst)
			out <= 32'b0;
		else if(en)
			out <= in;
		else
			out <= out;
	end
endmodule
