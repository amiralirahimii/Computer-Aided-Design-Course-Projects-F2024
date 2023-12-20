module controller(clk, start, complete, sel, en0, en1, en2, en3, done);
	input clk, start, complete;
	output reg sel, en0, en1, en2, en3, done;
	
	parameter[2:0] Q0=3'b000, Q1=3'b001, Q2=3'b010, Q3=3'b011, Q4=3'b100,
			Q5=3'b101, Q6=3'b110;

	wire[2:0] ps=3'b0, ns;
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



	always@(posedge clk)
	begin
		ps<=ns;
	end
	always@(ps,start,complete)
	begin
		case(ps)
			Q0 : ns= start ? Q1 : Q0 ;
			Q1 : ns= Q2 ;
			Q2 : ns= Q3 ;
			Q3 : ns= Q4 ;
			Q4 : ns= Q5 ;
			Q5 : ns= complete ? Q6 : Q3;
			Q6 : ns= Q0;
		endcase
	end
	always@(ps,start,complete)
	begin
		{sel, en0, en1, en2, en3, done}=6'b000000;
		case(ps)
			Q0 : ;
			Q1 : en0= 1'b1;
			Q2 : {sel, en1}= 2'b11;
			Q3 : en2= 1'b1;
			Q4 : ;
			Q5 : {sel, en1, en3}= 3'b011;
			Q6 : done= 1'b1;
		endcase
	end
endmodule