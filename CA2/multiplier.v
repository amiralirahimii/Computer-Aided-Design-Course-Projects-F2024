module multiplier(A, B, out);
	input signed[4:0] A, B;
	output reg[9:0] out;
	always @(*) begin
		out = A * B;
	end
endmodule

module multiplier #(parameter N = 5) (A, B, out);
    input signed [N - 1:0] A, B;
    output signed [2*N - 1:0] out;

    wire [2*N - 1:0] z;
    wire signbit_res;

    wire[N-1:0] abs_x, abs_y;
    abs_to_2scomplement #(N) absA(.a(A), .signbit(A[N-1]), .out(abs_x));
    abs_to_2scomplement #(N) absB(.a(B), .signbit(B[N-1]), .out(abs_y));
    wire Av [N : 0][N : 0];
    wire Bv [N : 0][N : 0];
    wire cv [N : 0][N : 0];
    wire pv [N : 0][N : 0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1)
        begin: gen_rows
            for (j = 0; j < N; j = j + 1)
            begin: gen_cols
                bit_multiplier bm(
                    .Ai(Av[i][j]), 
                    .Bi(Bv[i][j]),
                    .pi(pv[i][j + 1]),
                    .ci(cv[i][j]), 
                    .Ao(Av[i][j + 1]),
                    .Bo(Bv[i + 1][j]),
                    .po(pv[i + 1][j]),
                    .co(cv[i][j + 1])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < N; i = i + 1)
        begin: sides
            assign Av[i][0] = abs_x[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][N] = cv[i][N];
            assign Bv[0][i] = abs_y[i];
            assign z[i] = pv[i + 1][0];
            assign z[i + N] = pv[N][i + 1];
        end
    endgenerate
    
    Xor res_signbit(.a(A[N-1]), .b(B[N-1]), .out(signbit_res));
    abs_to_2scomplement #(2*N) twoscomplement(.a(z), .signbit(signbit_res), .out(out));

endmodule
