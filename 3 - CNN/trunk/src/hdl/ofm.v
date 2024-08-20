module OFM(clk, address,rdAdress, wrData,rdData, wr, done);
	parameter type;
	input clk, done;
	input[31:0] address;
	input[31:0] rdAdress;
	input[7:0] wrData[3:0];
	output[7:0] rdData[0:3];
	input wr;
	reg [31:0] mem[0:127];

	assign rdData[0] = mem[rdAdress][31:24];
	assign rdData[1] = mem[rdAdress][23:16];
	assign rdData[2] = mem[rdAdress][15:8];
	assign rdData[3] = mem[rdAdress][7:0];

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
		$readmemh($sformatf("file/filter%0d_L2.txt", type+1), mem);
		wait(done);
		file = $fopen($sformatf("file/output%0d_L1.txt", type+1), "w");
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