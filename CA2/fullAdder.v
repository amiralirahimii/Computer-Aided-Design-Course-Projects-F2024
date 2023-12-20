module fullAdder(A, B, cin, sum, cout);
    input A, B, cin;
    output sum, cout;
    wire xor1, and1, and2;

    Xor X1(A, B, xor1);
    Xor X2(xor1, cin, sum);
    And #2 A1({cin, xor1}, and1);
    And #2 A2({B, A}, and2);
    Or #2 O1({and1, and2}, cout);
endmodule