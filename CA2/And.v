module And #(parameter N = 2)(in, out);
    input [N-1:0] in;
    output out;
    wire [N-2:0] and_intermediate;
    wire kossher;
    genvar i;
    generate
        C1 C1_AND_INIT(.A0(1'b0),.A1(in[0]),.SA(in[1]),.B0(),.B1(),.SB(),.S0(1'b0),.S1(1'b0),.F(and_intermediate[0]));
        for (i = 1; i < N-1; i = i + 1)
        begin
            C1 C1_AND(.A0(1'b0), .A1(and_intermediate[i-1]), .SA(in[i+1]), .B0(),
                        .B1(), .SB(), .S0(1'b0), .S1(1'b0), .F(and_intermediate[i]));
        end
    endgenerate
    assign out = and_intermediate[N-2];
endmodule
