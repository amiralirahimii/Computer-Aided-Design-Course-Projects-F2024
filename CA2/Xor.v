module Xor(a,b,out);
    input a,b;
    wire not_a,not_b;
    wire and1_out,and2_out;
    output out; 
    
    Not NOT_A(a,not_a);
    Not NOT_B(b,not_b);

    And #2 AND1({not_a, b}, and1_out);
    And #2 AND2({a, not_b}, and2_out);

    Or #2 OR({and1_out, and2_out}, out);
endmodule