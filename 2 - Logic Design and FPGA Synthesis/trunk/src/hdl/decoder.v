module decoder(A1, A2, A3, A4, idx, done);
	input[4:0] A1, A2, A3, A4;
	output[1:0] idx;
	output done;
    wire isA1ZeroNot, isA2ZeroNot, isA3ZeroNot, isA4ZeroNot;


    Or #5 OR1(.in(A1), .out(isA1ZeroNot));
    Or #5 OR2(.in(A2), .out(isA2ZeroNot));
    Or #5 OR3(.in(A3), .out(isA3ZeroNot));
    Or #5 OR4(.in(A4), .out(isA4ZeroNot));


	wire isA1Zero, isA2Zero, isA3Zero, isA4Zero;


    Not NOT1(isA1ZeroNot, isA1Zero);
    Not NOT2(isA2ZeroNot, isA2Zero);
    Not NOT3(isA3ZeroNot, isA3Zero);
    Not NOT4(isA4ZeroNot, isA4Zero);

    wire[3:0] and1_in = {isA1Zero, isA2Zero, isA3Zero, isA4ZeroNot};
    wire[3:0] and2_in = {isA1Zero, isA2Zero, isA3ZeroNot, isA4Zero};
    wire[3:0] and3_in = {isA1Zero, isA2ZeroNot, isA3Zero, isA4Zero};
    wire[3:0] and4_in = {isA1ZeroNot, isA2Zero, isA3Zero, isA4Zero};
    
    wire and1_out,and2_out,and3_out,and4_out;
    
    And #4 AND1(.in(and1_in), .out(and1_out));
    And #4 AND2(.in(and2_in), .out(and2_out));
    And #4 AND3(.in(and3_in), .out(and3_out));
    And #4 AND4(.in(and4_in), .out(and4_out));

    wire[3:0] or5_in = {and1_out, and2_out, and3_out, and4_out};

    Or #4 OR5(.in(or5_in), .out(done));
    And #2 AND5(.in({isA1Zero, isA3Zero}), .out(idx[0]));
    And #2 AND6(.in({isA1Zero, isA2Zero}), .out(idx[1]));

endmodule