module bit_multiplier(Ai, Bi, pi, ci, Ao, Bo, po, co);
    input Ai, Bi, pi, ci;
    output Ao, Bo, po, co;

    wire wire1;

    And #2 AND1({Ai, Bi}, wire1);
    fullAdder FA(.A(wire1), .B(pi), .cin(ci), .sum(po), .cout(co));
    assign Ao = Ai;
    assign Bo = Bi;
endmodule