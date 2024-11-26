`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 02:51:09 PM
// Design Name: 
// Module Name: Multiplier_4bits_Task4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplier_4bits_Task4(
    input logic [3:0] A, 
    input logic [3:0] B, 
    output logic [7:0] P
    );
     
   logic [3:0] s1, s2, s3; 
   logic c1, c2; 
   assign  P[0]= B[0] & A[0];
   Adder_4bits adder1_inst(
    .A({1'b0, (A[3]&B[0]), (A[2]&B[0]), (A[1]&B[0])}), 
    .B({(B[1]&A[3]) , (B[1]&A[2]), (B[1]&A[1]), (B[1]&A[0])}), 
    .c_in(1'b0), 
    .c_out(c1), 
    .sum(s1)
    );
    
    assign P[1]= s1[0];
    
    Adder_4bits adder2_inst(
    .A({c1,s1[3:1]}), 
    .B({(B[2]&A[3]) , (B[2]&A[2]), (B[2]&A[1]), (B[2]&A[0])}), 
    .c_in(1'b0), 
    .c_out(c2), 
    .sum(s2)
    );
    
   assign P[2]= s2[0];
    
    Adder_4bits adder3_inst(
    .A({c2,s2[3:1]}), 
    .B({(B[3]&A[3]) , (B[3]&A[2]), (B[3]&A[1]), (B[3]&A[0])}), 
    .c_in(1'b0), 
    .c_out(P[7]), 
    .sum(P[6:3])
    ); 
endmodule
