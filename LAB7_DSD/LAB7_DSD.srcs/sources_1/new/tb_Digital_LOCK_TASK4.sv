`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 09:30:29 PM
// Design Name: 
// Module Name: tb_Digital_LOCK_TASK4
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


module tb_Digital_LOCK_TASK4;

    // Testbench signals
    logic clk;
    logic reset;
    logic [3:0] Password_in;
    logic open;
    logic close;
    logic LOCK_STATE;
    logic FAILED_STATE;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Instantiate the module
    Digital_LOCK_TASK4 uut (
        .clk(clk),
        .reset(reset),
        .Password_in(Password_in),
        .open(open),
        .close(close),
        .LOCK_STATE(LOCK_STATE),
        .FAILED_STATE(FAILED_STATE)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        reset = 0;          // Assert reset
        Password_in = 4'b0000;
        open = 0;
        close = 0;
        
        #15 reset = 1;      // Release reset

        // Test Case 1: Correct password
        #10 Password_in = 4'b1111; // Set correct password
        #10 open = 1; #10 open = 0; // Press and release "open"
        #20 $display("LOCK_STATE (Expected: 1 for Unlocked): %b, FAILED_STATE: %b", LOCK_STATE, FAILED_STATE);

        // Test Case 2: Close the lock
        #10 close = 1; #10 close = 0; // Press and release "close"
        #20 $display("LOCK_STATE (Expected: 0 for Locked): %b, FAILED_STATE: %b", LOCK_STATE, FAILED_STATE);

        // Test Case 3: Incorrect password 3 times
        #10 Password_in = 4'b0000; // Incorrect password
        repeat (3) begin
            #10 open = 1; #10 open = 0; // Press and release "open"
        end
        #20 $display("LOCK_STATE (Expected: 0 for Locked), FAILED_STATE (Expected: 1 for Failed): %b, %b", LOCK_STATE, FAILED_STATE);

        // Test Case 4: Wait for Failed state timeout (10 seconds = 100 million cycles)
        #100000000;
        $display("LOCK_STATE (Expected: 0 for Locked after timeout), FAILED_STATE (Expected: 0): %b, %b", LOCK_STATE, FAILED_STATE);

        // End simulation
        #50 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Password_in: %b | open: %b | close: %b | LOCK_STATE: %b | FAILED_STATE: %b",
                 $time, Password_in, open, close, LOCK_STATE, FAILED_STATE);
    end

endmodule
