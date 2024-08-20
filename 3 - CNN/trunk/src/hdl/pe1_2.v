module PE1_2 (clk,bufferInput,en1,sel,mac2Input,en2,rst2,macOut);
    input clk;
    input en2;
    input rst2;
    input [3:0] sel;
    input [7:0] bufferInput[0:3];
    input [15:0] en1;
    input [7:0] mac2Input;
    wire [7:0] bufferOut [0:15];
    wire [7:0] mac1Input;
    output [11:0] macOut;
    filterBuffer    Kernel(.clk(clk),.dataIn(bufferInput),.en(en1),.dataOut(bufferOut));
    mux16to1        Mux_16_1(.sel(sel),.in(bufferOut),.out(mac1Input));
    mac2             Mac(.a(mac1Input), .b(mac2Input), .en(en2), .rst(rst2), .clk(clk), .out(macOut));
endmodule