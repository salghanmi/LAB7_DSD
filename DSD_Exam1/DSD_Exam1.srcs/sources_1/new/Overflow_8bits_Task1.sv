`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 01:17:13 PM
// Design Name: 
// Module Name: Overflow_8bits_Task1
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


module Overflow_8bits_Task1(
    input logic  count,
    input logic clk, 
    input logic reset, 
    output logic overflow
    ); 
    
    logic q; 
    
    D_FF#(.n(1)) Dff_inst( 
    .d(count), 
    .reset(reset), 
    .enable(1'b1), 
    .clk(clk), 
    .q(q)

    );    
    
    assign overflow = ~count & q;
    
endmodule



