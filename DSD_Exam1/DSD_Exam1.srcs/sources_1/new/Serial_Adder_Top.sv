`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 06:21:27 PM
// Design Name: 
// Module Name: Serial_Adder_Top
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


module Serial_Adder_Top (
    input logic clk,
    input logic reset_n,
    input logic start,
    input logic load,
    input logic [3:0] A,    // 4-bit input A
    input logic [3:0] B,    // 4-bit input B
    output logic [4:0] Sum, // 5-bit sum output
    output logic Done       // Done signal
);

    logic [4:0] shift_reg_A, shift_reg_B, shift_reg_O;
    logic Cin, Cout, shift_en;
    logic [1:0] count;
    logic comparator_out;
    logic adder_sum;  // Intermediate signal for the full-adder sum output

    // Shift register A
    ShiftRegister #(.WIDTH(5)) shift_reg_A_inst (
        .clk(clk),
        .reset_n(reset_n),
        .load(load),
        .shift_en(shift_en),
        .in({1'b0, A}), // Extend A to 5 bits by prepending 0
        .out(shift_reg_A)
    );

    // Shift register B
    ShiftRegister #(.WIDTH(5)) shift_reg_B_inst (
        .clk(clk),
        .reset_n(reset_n),
        .load(load),
        .shift_en(shift_en),
        .in({1'b0, B}), // Extend B to 5 bits by prepending 0
        .out(shift_reg_B)
    );

    // Shift register for output (Sum)
    shift_register_with_adder #(.WIDTH(5)) shift_reg_O_inst (
        .clk(clk),
        .reset_n(reset_n),
        .load(1'b0),             // Always in shift mode
        .shift_en(shift_en),     // Enable for shifting
        .sum_in(adder_sum),      // Sum from the full-adder
        .carry_in(Cout),         // Carry-in for the next cycle
        .out(shift_reg_O)        // Output (Sum)
    );

    // Full-adder for bit-by-bit addition
    FullAdder FA_inst (
        .A(shift_reg_A[0]),   // LSB of A
        .B(shift_reg_B[0]),   // LSB of B
        .Cin(Cin),            // Carry-in
        .Sum(adder_sum),      // Full-adder Sum
        .Cout(Cout)           // Full-adder Carry-out
    );

    // D flip-flop for carry propagation
    dff DFF_inst (
        .clk(clk),
        .reset_n(reset_n),
        .D(Cout),
        .Q(Cin)               // Propagate carry-out to carry-in for the next cycle
    );

    // 2-bit counter to track the number of bits processed
    counter1 #(.WIDTH(2)) counter_inst (
        .clk(clk),
        .reset_n(reset_n),
        .enable(shift_en),
        .count(count)
    );

    // Comparator to determine when the addition is complete
    assign comparator_out = (count == 2'b11);  // Stop after 4 bits are processed
    assign shift_en = start & ~comparator_out; // Enable shifting while not done
    assign Done = comparator_out;              // Signal when addition is complete
    assign Sum = shift_reg_O;                  // Final sum output

endmodule
