module absToTwosComp #(parameter N=5) (in, sign, out);
    input [N-1:0] in;
    input sign;
    output [N-1:0] out;

    wire [N-1:0] onesCompIn;
    wire [N-1:0] one;

    assign one = {{(N-1){1'b0}}, sign};
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
            Xor xori(.a(in[i]), .b(sign), .out(onesCompIn[i]));
        end
    endgenerate

    wire[N:0] temp;
    adder #N myAdder(.A(onesCompIn), .B(one), .result(temp));
    assign out = temp[N-1:0];
endmodule