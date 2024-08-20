module counter25(input clk, rst, en, output cout, output reg [31:0] count);
	always @(posedge clk)
	begin
		if(rst)
			count <= 32'b0;
		else if(en)
			count<= (count==24) ? 32'b0 : count+1;
	end
	assign cout = (count == 24) ? 1'b1 : 1'b0;
endmodule 
