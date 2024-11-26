`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 06:10:07 PM
// Design Name: 
// Module Name: ShiftRegister
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


module ShiftRegister #(parameter WIDTH = 5) (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic shift_en,
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            out <= '0;
        else if (load)
            out <= in;
        else if (shift_en)
            out <= {1'b0, out[WIDTH-1:1]}; // Right shift
    end
endmodule


