module abs_to_2scomplement #(parameter N = 5) (in, sign, out);
    input [N-1:0] in;
    input sign;
    output [N-1:0] out;

    wire [N-1:0] inverted_a;
    wire [N-1:0] one;

    assign one = {{(N-1){1'b0}}, sign};
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
            Xor xori(.in(in[i]), .b(sign), .out(inverted_a[i]));
        end
    endgenerate

    wire[N:0] temp;
    adder #N myAdder(.A(inverted_a), .B(one), .result(temp));
    assign out = temp[N-1:0];
endmodule