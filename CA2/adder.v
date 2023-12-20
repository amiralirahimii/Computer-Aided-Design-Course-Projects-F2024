module adder #(parameter N=10) (A, B, result);
	input signed[N-1:0] A, B;
	reg[N:0] temp;
	output reg[N:0] result;
	always @(*) begin
		temp = A + B;
		result = {temp[N-1], temp[N-1:0]};
	end
endmodule