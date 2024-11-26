`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 07:44:02 PM
// Design Name: 
// Module Name: SerialAdder
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
module SerialAdder (
    input logic clk,
    input logic rst,
    input logic [3:0] a,    // 4-bit input A
    input logic [3:0] b,    // 4-bit input B
    input logic cin,        // Initial carry-in
    output logic [4:0] sum, // 5-bit sum output (to include final carry)
    output logic done       // Done signal
);

    // Internal registers
    logic [3:0] a_reg, b_reg;  // Shift registers for A and B
    logic carry;               // Carry for each bit addition
    logic [4:0] sum_reg;       // Shift register to accumulate the sum
    logic [2:0] bit_count;     // Counter to track the number of processed bits
    logic sum_bit;             // Temporary sum bit
    logic next_carry;          // Temporary next carry

    // Full adder instance
    FullAdder1 fa (
        .A(a_reg[0]),         // Current LSB of A
        .B(b_reg[0]),         // Current LSB of B
        .Cin(carry),          // Carry-in
        .Sum(sum_bit),        // Temporary sum bit
        .Cout(next_carry)     // Next carry-out
    );

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers and signals
            a_reg <= a;         // Load input A into the shift register
            b_reg <= b;         // Load input B into the shift register
            sum_reg <= 0;       // Clear the sum register
            carry <= cin;       // Initialize carry-in
            bit_count <= 0;     // Reset the bit counter
            done <= 0;          // Clear the done signal
        end else if (bit_count < 4) begin
            // Perform addition for each bit
            sum_reg <= {sum_bit, sum_reg[4:1]}; // Store sum bit and shift sum right
            a_reg <= {1'b0, a_reg[3:1]};        // Shift A to the right
            b_reg <= {1'b0, b_reg[3:1]};        // Shift B to the right
            carry <= next_carry;                // Update carry for next bit
            bit_count <= bit_count + 1;         // Increment bit counter
        end else begin
            // Finish addition after processing all 4 bits
            sum_reg <= {next_carry, sum_reg[4:1]}; // Store the final carry in MSB
            done <= 1;                             // Indicate completion
        end
    end

    // Assign outputs
    assign sum = sum_reg; // Assign the accumulated sum to the output

endmodule



module FullAdder1 (
    input logic A,
    input logic B,
    input logic Cin,
    output logic Sum,
    output logic Cout
);
    assign {Cout, Sum} = A + B + Cin;
endmodule
