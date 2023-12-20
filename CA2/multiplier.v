module multiplier #(parameter N = 5) (A, B, out);
    input signed [N-1:0] A, B;
    output signed [2*N-1:0] out;

	wire signResult;
    wire [2*N-1:0] z;
    wire[N-1:0] absA, absB;

    abs_to_2scomplement #(N) absA(.in(A), .sign(A[N-1]), .out(absA));
    abs_to_2scomplement #(N) absB(.in(B), .sign(B[N-1]), .out(absB));

    wire Av[N:0][N:0];
    wire Bv[N:0][N:0];
    wire cv[N:0][N:0];
    wire pv[N:0][N:0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
            for (j = 0; j < N; j = j + 1)
            begin
                bitMultiplier BM(.Ai(Av[i][j]), .Bi(Bv[i][j]), .pi(pv[i][j + 1]),
								.ci(cv[i][j]), .Ao(Av[i][j + 1]), .Bo(Bv[i + 1][j]),
								.po(pv[i + 1][j]), .co(cv[i][j + 1]));
            end
        end
    endgenerate

    generate
        for (i = 0; i < N; i = i + 1)
        begin
            assign Av[i][0] = absA[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i+1][N] = cv[i][N];
            assign Bv[0][i] = absB[i];
            assign z[i] = pv[i + 1][0];
            assign z[i+N] = pv[N][i+1];
        end
    endgenerate
    
    Xor myXOR(.a(A[N-1]), .b(B[N-1]), .out(signResult));
    abs_to_2scomplement #(2*N) myABS(.in(z), .sign(signResult), .out(out));

endmodule
