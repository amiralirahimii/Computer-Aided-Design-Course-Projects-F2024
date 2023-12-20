module multiplier(A, B, out);
	input signed[4:0] A, B;
	output reg[9:0] out;
	always @(*) begin
		out = A * B;
	end
endmodule