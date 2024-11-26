`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 06:43:53 PM
// Design Name: 
// Module Name: dff
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



module dff (
    input logic clk,
    input logic reset_n,
    input logic D,
    output logic Q
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule

