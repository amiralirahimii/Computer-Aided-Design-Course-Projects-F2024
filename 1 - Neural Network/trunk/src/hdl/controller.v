module controller(clk, start, complete, sel, en0, en1, en2, en3, done);
	input clk, start, complete;
	output reg sel, en0, en1, en2, en3, done;
	
	parameter[2:0] Q0=3'b000, Q1=3'b001, Q2=3'b010, Q3=3'b011, Q4=3'b100,
			Q5=3'b101, Q6=3'b110;

	reg[2:0] ps=3'b0, ns;
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
