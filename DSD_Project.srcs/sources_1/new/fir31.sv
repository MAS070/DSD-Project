`timescale 1ns / 1ps            // Compiler/Simulator Directive

// Module start
module FIR_Filter(Clk, In, Out, MUL0);

//decleration of input and output 
input Clk;
input signed [15:0] In; 
output reg signed [63:0] Out;
output wire signed [31:0] MUL0;

//Decleration of reg and wire. 
wire [15:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10;
wire [15:0] b11, b12, b13, b14, b15, b16, b17, b18, b19, b20;
wire [15:0] b21, b22, b23, b24, b25, b26, b27, b28, b29, b30;                    // 3rd order MAF has 4 co-efficents
wire [31:0] MUL1, MUL2, MUL3, MUL4, MUL5, MUL6, MUL7, MUL8, MUL9, MUL10;
wire [31:0] MUL11, MUL12, MUL13, MUL14, MUL15, MUL16, MUL17, MUL18, MUL19, MUL20;
wire [31:0] MUL21, MUL22, MUL23, MUL24, MUL25, MUL26, MUL27, MUL28, MUL29, MUL30;
wire [63:0] Add;   
wire [15:0] Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10;
wire [15:0] Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20;
wire [15:0] Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31;                          // output for DFF
reg reset;

//filter coefficient for moving average filter
//   assign b0 =  0;
//   assign b1 = 1;
//   assign b2 = 3;
//   assign b3 = 4;
//   assign b4 = 4;
//   assign b5 = 0;
//   assign b6 = 0;
//   assign b7 = 0;
//   assign b8 = 0;
//   assign b9 = 0;
//   assign b10 =0;
//   assign b11 =41;
//   assign b12 =94;
//   assign b13 =149;
//   assign b14 =189;
//   assign b15 =204;
//   assign b16 =189;
//   assign b17 =149;
//   assign b18 =94;
//   assign b19 =41;
//   assign b20 =0;
//   assign b21 =0;
//   assign b22 =0;
//   assign b23 =0;
//   assign b24 =0;
//   assign b25 =0;
//   assign b26 =4;
//   assign b27 =4;
//   assign b28 =3;
//   assign b29 =1;
//   assign b30 =0;

 assign b0=32;
 assign b1=32;
 assign b2=32;
 assign b3=32;
 assign b4=32;
 assign b5=33;
  assign b6=33;
  assign b7=33;
  assign b8=33;
  assign b9=33;
  assign b10=33;
   assign b11=33;
   assign b12=33;
   assign b13=33;
   assign b14=33;
   assign b15=33;
    assign b16=33;
    assign b17=33;
    assign b18=33;
    assign b19=33;
    assign b20=33;
     assign b21=33;
     assign b22=33;
     assign b23=33;
     assign b24=33;
     assign b25=33;
      assign b26=33;
      assign b27=33;
      assign b28=33;
      assign b29=33;
      assign b30=33;
       
       


//Module instantiation (D-FF) 
DFF dff1 (Clk, 1'b0, In, Q1);
DFF dff2 (Clk, 1'b0, Q1, Q2);
DFF dff3 (Clk, 1'b0, Q2, Q3);
DFF dff4 (Clk, 1'b0, Q3, Q4);
DFF dff5 (Clk, 1'b0, Q4, Q5);
DFF dff6 (Clk, 1'b0, Q5, Q6);
DFF dff7 (Clk, 1'b0, Q6, Q7);
DFF dff8 (Clk, 1'b0, Q7, Q8);
DFF dff9 (Clk, 1'b0, Q8, Q9);
DFF dff10 (Clk, 1'b0, Q9, Q10);
DFF dff11 (Clk, 1'b0, Q10, Q11);
DFF dff12 (Clk, 1'b0, Q11, Q12);
DFF dff13 (Clk, 1'b0, Q12, Q13);
DFF dff14 (Clk, 1'b0, Q13, Q14);
DFF dff15 (Clk, 1'b0, Q14, Q15);
DFF dff16 (Clk, 1'b0, Q15, Q16);
DFF dff17 (Clk, 1'b0, Q16, Q17);
DFF dff18 (Clk, 1'b0, Q17, Q18);
DFF dff19 (Clk, 1'b0, Q18, Q19);
DFF dff20 (Clk, 1'b0, Q19, Q20);
DFF dff21 (Clk, 1'b0, Q20, Q21);
DFF dff22 (Clk, 1'b0, Q21, Q22);
DFF dff23 (Clk, 1'b0, Q22, Q23);
DFF dff24 (Clk, 1'b0, Q23, Q24);
DFF dff25 (Clk, 1'b0, Q24, Q25);
DFF dff26 (Clk, 1'b0, Q25, Q26);
DFF dff27 (Clk, 1'b0, Q26, Q27);
DFF dff28 (Clk, 1'b0, Q27, Q28);
DFF dff29 (Clk, 1'b0, Q28, Q29);
DFF dff30 (Clk, 1'b0, Q29, Q30);
DFF dff31 (Clk, 1'b0, Q30, Q31);



//Multiplications of co-efficents
assign MUL0 = b0*In;
assign MUL1 = b1*Q1;
assign MUL2 = b2*Q2;
assign MUL3 = b3*Q3;
assign MUL4 = b4*Q4;
assign MUL5 = b5*Q5;
assign MUL6 = b6*Q6;
assign MUL7 = b7*Q7;
assign MUL8 = b8*Q8;
assign MUL9 = b9*Q9;
assign MUL10 = b10*Q10;
assign MUL11 = b11*Q11;
assign MUL12 = b12*Q12;
assign MUL13 = b13*Q13;
assign MUL14 = b14*Q14;
assign MUL15 = b15*Q15;
assign MUL16 = b16*Q16;
assign MUL17 = b17*Q17;
assign MUL18 = b18*Q18;
assign MUL19 = b19*Q19;
assign MUL20 = b20*Q20;
assign MUL21 = b21*Q21;
assign MUL22 = b22*Q22;
assign MUL23 = b23*Q23;
assign MUL24 = b24*Q24;
assign MUL25 = b25*Q25;
assign MUL26 = b26*Q26;
assign MUL27 = b27*Q27;
assign MUL28 = b28*Q28;
assign MUL29 = b29*Q29;
assign MUL30 = b30*Q30;

//Addition operation for getting result
assign Add = MUL0 + MUL1 + MUL2 + MUL3 +MUL4 ;
//             + MUL5 + MUL6 + MUL7+ MUL8 + MUL9 + MUL10 +
//             MUL11 + MUL12
//              + MUL13 +MUL14
//              + MUL15 
//             + MUL16
//             + MUL17
//              + MUL18 + MUL19 + MUL20 +   MUL21 + MUL22 + MUL23 +MUL24 + MUL25 + MUL26 + MUL27 + MUL28 + MUL29 + MUL30;
//// giving add_out to Out
always@ (posedge Clk)
Out <= Add;

// end module
endmodule


// D-FF module
 
module DFF(clk, reset, D, Q);

// Input and output decleration
input clk, reset;
input signed [15:0] D;
output reg [15:0] Q;

// (logic)
always@(posedge clk, posedge reset)
begin
    if (reset)
    Q <= 0;
    else
    Q <= D;
end

endmodule