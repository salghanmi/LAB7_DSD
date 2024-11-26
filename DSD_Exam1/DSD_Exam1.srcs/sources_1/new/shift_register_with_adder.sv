`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 06:50:55 PM
// Design Name: 
// Module Name: shift_register_with_adder
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


module shift_register_with_adder #(parameter WIDTH = 5) (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic shift_en,
    input logic sum_in,               // Sum from the full-adder
    input logic carry_in,             // Carry-in for the next cycle
    output logic [WIDTH-1:0] out      // Output of the shift register
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            out <= '0;
        else if (load)
            out <= '0;  // Clear output on load
        else if (shift_en)
            out <= {carry_in, out[WIDTH-1:1]}; // Shift in carry-in at MSB
        else
            out[0] <= sum_in;                 // Update LSB with full-adder sum
    end
endmodule

