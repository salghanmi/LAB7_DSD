`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 02:09:36 PM
// Design Name: 
// Module Name: Detect_odd_ones_Task2
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


module Detect_odd_ones_Task2(
    input logic [7:0] d, 
    output logic out
    );
    
   assign  out = ^d; 
   
endmodule
