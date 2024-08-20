module decoder(A1, A2, A3, A4, idx, done);
	input[31:0] A1, A2, A3, A4;
	output reg[1:0] idx;
	output reg done;
	wire isA1Zero, isA2Zero, isA3Zero, isA4Zero;
	assign isA1Zero = ~|A1[30:0];
	assign isA2Zero = ~|A2[30:0];
	assign isA3Zero = ~|A3[30:0];
	assign isA4Zero = ~|A4[30:0];
	always@(A1, A2, A3, A4)
	begin
		{idx, done} = 3'b000;
		if({isA1Zero, isA2Zero, isA3Zero, isA4Zero} == {4'b1110})
		begin
			idx = 2'b11;
			done = 1'b1;
		end
		else if({isA1Zero, isA2Zero, isA3Zero, isA4Zero} == {4'b1101})
		begin
			idx = 2'b10;
			done = 1'b1;
		end
		else if({isA1Zero, isA2Zero, isA3Zero, isA4Zero} == {4'b1011})
		begin
			idx = 2'b01;
			done = 1'b1;
		end
		else if({isA1Zero, isA2Zero, isA3Zero, isA4Zero} == {4'b0111})
		begin
			idx = 2'b00;
			done = 1'b1;
		end
	end
endmodule
