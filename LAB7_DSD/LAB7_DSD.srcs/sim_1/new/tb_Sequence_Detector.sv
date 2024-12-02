`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:31:25 PM
// Design Name: 
// Module Name: tb_Sequence_Detector
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


module tb_Sequence_Detector;


    // Testbench signals
    logic clk;
    logic reset;
    logic in_bit;
    logic detected;
    logic [3:0] count;

    // Instantiate the Sequence Detector
    Sequence_Detector_Task1 uut (
        .clk(clk),
        .reset(reset),
        .in_bit(in_bit),
        .detected(detected),
        .count(count)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 5ns high, 5ns low (10ns period)
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        in_bit = 0;

        // Release reset after some time
        #15 reset = 0;

        // Apply test sequence: 1101101
        #10 in_bit = 1;  // State: S1
        #10 in_bit = 1;  // State: S2
        #10 in_bit = 0;  // State: S3
        #10 in_bit = 1;  // State: S4 (1st detection)
        #10 in_bit = 1;  // State: S2 (overlapping starts)
        #10 in_bit = 0;  // State: S3
        #10 in_bit = 1;  // State: S4 (2nd detection)

        // Reset the system
        #10 reset = 1;
        #10 reset = 0;

        // Apply another test sequence: 11101101
        #10 in_bit = 1;  // State: S1
        #10 in_bit = 1;  // State: S2
        #10 in_bit = 1;  // State: S2 (repeated)
        #10 in_bit = 0;  // State: S3
        #10 in_bit = 1;  // State: S4 (3rd detection)
        #10 in_bit = 1;  // State: S2 (overlapping starts)
        #10 in_bit = 0;  // State: S3
        #10 in_bit = 1;  // State: S4 (4th detection)

        // Stop the simulation
        #50 $finish;
    end

    // Monitor output for debugging
    initial begin
        $monitor("Time: %0t | in_bit: %b | detected: %b | count: %0d | current_state: %0d", 
                 $time, in_bit, detected, count, uut.current_state);
    end

endmodule




