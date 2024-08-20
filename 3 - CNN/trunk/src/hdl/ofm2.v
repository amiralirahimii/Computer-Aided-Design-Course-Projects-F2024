module OFM2(clk, address, wrData, wr, done);
	parameter type;
	input clk, done;
	input[31:0] address;
	input[7:0] wrData[3:0];
	input wr;
	reg [31:0] mem[0:127];

	always@(posedge clk)
	begin
		if(wr)
		begin
			mem[address][31:24] = wrData[0];
			mem[address][23:16] = wrData[1];
			mem[address][15:8] = wrData[2];
			mem[address][7:0] = wrData[3];
		end
	end

	integer file, i;
	initial
	begin
		wait(done);
		file = $fopen($sformatf("file/output%0d_L2.txt", type+1), "w");
		if (file) 
		begin
			$display("Number is: %d", type);
			for (i = 0; i < 128; i=i+1)
			begin
				$fwrite(file, "%08x\n", mem[i]);
			end
			$fclose(file);
		end 
		else 
		begin
			$display("Error: could not open file.");
		end
	end
	
endmodule