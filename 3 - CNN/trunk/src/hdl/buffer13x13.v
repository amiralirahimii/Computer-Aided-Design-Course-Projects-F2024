module buffer13x13(clk,en,dataIn,address,k,q,dataOut);
	input [7:0] dataIn[0:3];
	input clk, en;
    input [31:0] address;
    input [3:0] k, q;
	reg [7:0] buffer [0:12][0:12];
	output reg [7:0] dataOut[0:15];
	integer i,j;
	always@(posedge clk) begin
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 0; j <= 3; j = j + 1) begin
                dataOut[4*i + j] = buffer[i + k][j + q];
            end
  		end
	end
	always@(posedge clk) begin
		if(en) begin
            i = (address * 4) / 13;
            j = (address * 4) % 13;
            if(i==12 && j==12)begin
                buffer[12][12] <= dataIn[0];
            end
            else begin
            buffer[i][j] <= dataIn[0];
			buffer[i + ((j+1) > 12)][(j+1) % 13] <= dataIn[1];
		    buffer[i + ((j+2) > 12)][(j+2) % 13] <= dataIn[2];
			buffer[i + ((j+3) > 12)][(j+3) % 13] <= dataIn[3];
            end
		end
	end
	
endmodule