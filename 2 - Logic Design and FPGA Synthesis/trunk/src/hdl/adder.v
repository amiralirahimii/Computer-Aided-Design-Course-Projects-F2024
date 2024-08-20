module adder #(parameter N=10) (A, B, result);
    input[N-1:0] A, B;
    output[N:0] result;
    wire [N-1:0] sum;
    wire [N:0] carry;

    assign carry[0] = 0;
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) 
		begin
            fullAdder fa(.A(A[i]), .B(B[i]), .cin(carry[i]), .sum(sum[i]),
                		.cout(carry[i+1]));
        end
    endgenerate

	assign result = {sum[N-1], sum[N-1:0]};
endmodule
