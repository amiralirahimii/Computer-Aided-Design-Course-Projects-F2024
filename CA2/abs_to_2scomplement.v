module abs_to_2scomplement #(parameter N = 5) (a, signbit, out);
    input [N-1:0] a;
    input signbit;
    output [N-1:0] out;

    wire [N-1:0] inverted_a;
    wire [N-1:0] one;

    assign one = {{(N-1){1'b0}}, signbit };
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : XOR_LOOP
            Xor xor_i (.a(a[i]), .b(signbit), .out(inverted_a[i]));
        end
    endgenerate

    wire[N:0] temp;
    adder #N adder1(.A(inverted_a), .B(one), .result(temp));
    assign out = temp[N-1:0];
endmodule