module adder #(parameter N=10) (A, B, result);
	input[N-1:0] A, B;
	output reg[N:0] result;
	always @(*) begin
		result = A + B;
	end
endmodule