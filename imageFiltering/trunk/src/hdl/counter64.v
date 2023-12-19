module counter64(input clk, rst, en, output cout, output reg [5:0] count);
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			count <= 6'b000000;
		else if(en)
			count <= count+1;
	end
	assign cout = (count == 6'b111111) ? 1'b1 : 1'b0;
endmodule
