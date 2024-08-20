module counter10(input clk, rst, en, output cout, output reg [3:0] count);
	always @(posedge clk)
	begin
		if(rst)
			count <= 4'b0000;
		else if(en) 
			count <= (count == 9)? 0 : count+1;
	end
	assign cout = (count == 9) ? 1'b1 : 1'b0;
endmodule 