module PE2(clk,sel,en0,en1,en2,en3,rst0,rst3,mac2Input,bufferInput,cout3,shiftRegOut);

    input clk;
    input en0,en2,en3;
    input rst0,rst3;
    input [3:0] sel;
	input[7:0] mac2Input[0:3];
    input [7:0] bufferInput[0:3];
    input [15:0] en1 [0:3];


    output cout3;
    output[7:0] shiftRegOut[0:3];


    wire [11:0] macOut[0:3];
    wire [13:0] totalSum ;
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1)
        begin
            PE1_2 pe1_2(.clk(clk),.bufferInput(bufferInput),.en1(en1[i]),.sel(sel),.mac2Input(mac2Input[i]),.en2(en0),.rst2(rst0),.macOut(macOut[i]));
        end
    endgenerate
    assign totalSum=macOut[0]+macOut[1]+macOut[2]+macOut[3];
    shiftRegister   shiftReg(.clk(clk),.en(en2),.dataIn(totalSum[11:4]),.dataOut(shiftRegOut));
    counter4        cnt4(.clk(clk),.rst(rst3),.en(en3),.cout(cout3),.count());

endmodule