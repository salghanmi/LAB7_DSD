`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 06:24:00 PM
// Design Name: 
// Module Name: tb_Serial_Adder_Top
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


module tb_Serial_Adder_Top;

    // Testbench signals
    logic clk, rst;
    logic [3:0] a, b;
    logic cin;
    logic [4:0] sum;
    logic done;

    // Instantiate the DUT (Device Under Test)
    SerialAdder dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test process
    initial begin
        // Initialize inputs
        rst = 1;
        a = 0;
        b = 0;
        cin = 0;

        // Reset the design
        #10 rst = 0;

        // Test Case 1: Add 4'b0101 (5) and 4'b0011 (3)
        a = 4'b0101;
        b = 4'b0011;
        cin = 0; // No initial carry
        #70; // Wait for 4 clock cycles
        
        // Test Case 2: Add 4'b1111 (15) and 4'b0001 (1)
        rst = 1; #10; rst = 0; // Reset
        a = 4'b1101;
        b = 4'b0001;
        cin = 0;
        #50; // Wait for 4 clock cycles

        $stop;
    end

endmodule



