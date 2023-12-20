module Or #(parameter N = 2)(in, out);
    input [N-1:0] in;
    output out;
    wire [N-2:0] or_intermediate;

    genvar i;
    generate
        C1 C1_OR_INIT(.A0(in[0]), .A1(1'b1), .SA(in[1]), .B0(),
                    .B1(), .SB(), .S0(1'b0), .S1(1'b0), .F(or_intermediate[0]));
        for (i = 1; i < N-1; i = i + 1)
        begin
            C1 C1_OR(.A0(or_intermediate[i-1]), .A1(1'b1), .SA(in[i+1]), .B0(),
                    .B1(), .SB(), .S0(1'b0), .S1(1'b0), .F(or_intermediate[i]));
        end
    endgenerate
    assign out = or_intermediate[N-2];

endmodule
