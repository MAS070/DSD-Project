`timescale 1ns / 1ps



module FIR_Filter_TestBench;
//parameter N = 16;
//parameter address = 5;

 // Inputs
 logic Clk;
 logic reset;
 logic [6-1:0] addr;
 logic signed [16-1:0] Xin;
 logic signed [16-1:0] ram [0:31];

 // Outputs
 logic signed [24-1:0] Yout;

 //Generate a clock with 10 ns clock period.
initial
Clk = 0;
always
#5 Clk =~Clk;

 // Generate RAM Addresses
 initial
addr=0;
 always
 #10 addr = addr+1;

 // Read data file and assign data to memory
 initial begin
// $readmemb("signal.data",ram);
$readmemb("signal.data",ram);

 end

 // Assign memory data to the Input of the filter
 always @(posedge Clk)
 begin
 Xin <= ram[addr];
 end
 
// Instantiate the DUT
fir31 dut(.clk_in(Clk), .rst_in(0),
            .x_in(Xin),.y_out(Yout));
//FIR_Filter inst0(Clk, Xin, Yout);


endmodule
