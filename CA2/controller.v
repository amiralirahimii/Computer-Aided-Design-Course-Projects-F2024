module controller(clk, start, complete, sel, en0, en1, en2, en3, done);
	input clk, start, complete;
	output sel, en0, en1, en2, en3, done;
	
	wire[2:0] ps=3'b0;
	wire[2:0] ns;
    wire[2:0] notPs;
    Not NOTPS2(ps[2], notPs[2]);
    Not NOTPS1(ps[1], notPs[1]);
    Not NOTPS0(ps[0], notPs[0]);

    wire PS2Product1, PS2Product2, PS2Product3_1, PS2Product3_2;
    wire PS1Product1, PS1Product2, PS1Product3;
    wire PS0Product1_1, PS0Product1_2, PS0Product2, PS0Product3, PS0Product4_1, PS0Product4_2;

    //finding ns[2]
    And #3 AND1({notPs[2], ps[1], ps[0]}, PS2Product1);
    And #3 AND2({ps[2], notPs[1], notPs[0]}, PS2Product2);
    And #3 AND3({ps[2], notPs[1], ps[0]}, PS2Product3_1);
    mux2x1 #1 MUX1(1'b0, PS2Product3_1, complete, PS2Product3_2);
    Or #3 OR1({PS2Product1, PS2Product2, PS2Product3_2}, ns[2]);

    //finding ns[1]
    And #3 AND4({notPs[2], notPs[1], ps[0]}, PS1Product1);
    And #3 AND5({notPs[2], ps[1], notPs[0]}, PS1Product2);
    And #3 AND6({ps[2], notPs[1], ps[0]}, PS1Product3);
    Or #3 OR2({PS1Product1, PS1Product2, PS1Product3}, ns[1]);

    //finding ns[0]
    And #3 AND7({notPs[2], notPs[1], notPs[0]}, PS0Product1_1);
    mux2x1 #1 MUX2(1'b0, PS0Product1_1, start, PS0Product1_2);
    And #3 AND8({notPs[2], ps[1], notPs[0]}, PS0Product2);
    And #3 AND9({ps[2], notPs[1], notPs[0]}, PS0Product3);
    And #3 AND10({ps[2], notPs[1], ps[0]}, PS0Product4_1);
    mux2x1 #1 MUX3(PS0Product4_1, 1'b0, complete, PS0Product4_2);
    Or #4 OR3({PS0Product1_2, PS0Product2, PS0Product3, PS0Product4_2}, ns[0]);

    //finding output signals
    wire en1Gen1, en1Gen2;

    And #3 AND11({notPs[2], notPs[1], ps[0]}, en0);
    And #3 AND12({notPs[2], ps[1], notPs[0]}, sel);
    And #3 AND13({notPs[2], ps[1], notPs[0]}, en1Gen1);
    And #3 AND14({ps[2], notPs[1], ps[0]}, en1Gen2);
    Or #2 OR4({en1Gen1, en1Gen2}, en1);
    And #3 AND15({notPs[2], ps[1], ps[0]}, en2);
    And #3 AND16({ps[2], notPs[1], ps[0]}, en3);
    And #3 AND17({ps[2], ps[1], notPs[0]}, done);

    register #3 (.clk(clk), .rst(1'b0), .en(1'b1), .in(ns), .out(ps));
endmodule