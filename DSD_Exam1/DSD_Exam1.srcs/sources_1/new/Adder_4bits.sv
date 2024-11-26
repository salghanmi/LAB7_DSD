`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 02:26:28 PM
// Design Name: 
// Module Name: Adder_4bits
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


module Adder_4bits(
    input logic [3:0] A, 
    input logic [3:0] B, 
    input logic c_in, 
    output logic c_out, 
    output logic [3:0] sum
    );
    
    assign {c_out ,sum} = A + B; 
    
    
endmodule
