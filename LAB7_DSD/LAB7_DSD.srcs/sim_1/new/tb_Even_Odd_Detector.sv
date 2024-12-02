`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 02:44:27 PM
// Design Name: 
// Module Name: tb_Even_Odd_Detector
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


module tb_Even_Odd_Detector;

    // Testbench signals
    logic clk;
    logic reset;
    logic in_bit;
    logic Zero_even_detected;
    logic One_even_detect;

    // Instantiate the module
    Even_Odd_Detector_Task2 uut (
        .clk(clk),
        .reset(reset),
        .in_bit(in_bit),
        .Zero_even_detected(Zero_even_detected),
        .One_even_detect(One_even_detect)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize
        reset = 1;
        in_bit = 0;
        #15 reset = 0;

        // Sequence: 1, 0, 0, 1, 1, 0
        #10 in_bit = 1; // 1 -> Ones odd
        #10 in_bit = 0; // 10 -> Zeros even
        #10 in_bit = 0; // 100 -> Zeros odd
        #10 in_bit = 1; // 1001 -> Ones even
        #10 in_bit = 1; // 10011 -> Ones odd
        #10 in_bit = 0; // 100110 -> Zeros even

        // Reset again
        #10 reset = 1;
        #10 reset = 0;

        // Sequence: 0, 0, 1, 1, 0
        #10 in_bit = 0; // 0 -> Zeros even
        #10 in_bit = 0; // 00 -> Zeros odd
        #10 in_bit = 1; // 001 -> Ones odd
        #10 in_bit = 1; // 0011 -> Ones even
        #10 in_bit = 0; // 00110 -> Zeros even

        #50 $finish; // End simulation
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | in_bit: %b | Zero_even_detected: %b | One_even_detect: %b | Current state: %0d",
                 $time, in_bit, Zero_even_detected, One_even_detect, uut.current_state);
    end

endmodule

