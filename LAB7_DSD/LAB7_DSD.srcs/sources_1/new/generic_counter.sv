`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 09:12:44 PM
// Design Name: 
// Module Name: generic_counter
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

module generic_counter(
    input clk,          // Clock signal
    input reset,        // Active high reset
    input enable,       // Enable counting
    input [5:0] max_value, // Maximum count value (e.g., 59 or 12)
    output reg [5:0] count, // Current count value
    output reg overflow     // Overflow signal
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            overflow <= 0;
        end else if (enable) begin
            if (count == max_value) begin
                count <= 0;
                overflow <= 1; // Generate overflow when max is reached
            end else begin
                count <= count + 1;
                overflow <= 0;
            end
        end
    end
endmodule

