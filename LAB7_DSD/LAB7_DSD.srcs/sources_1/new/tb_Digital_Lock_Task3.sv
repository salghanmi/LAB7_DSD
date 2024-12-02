`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 03:49:48 PM
// Design Name: 
// Module Name: tb_Digital_Lock_Task3
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


module tb_Digital_Lock_Task3;

    // Testbench signals
    logic clk;
    logic reset;
    logic [3:0] Password_in;
    logic open;
    logic close;
    logic LOCK_STATE;

    // Instantiate the module
    Digital_Lock_Task3 uut (
        .clk(clk),
        .reset(reset),
        .Password_in(Password_in),
        .open(open),
        .close(close),
        .LOCK_STATE(LOCK_STATE)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        Password_in = 4'b0000; // Default password input
        open = 0;
        close = 0;

        #15 reset = 0; // Release reset

        // Enter incorrect password and press "Open"
        #10 Password_in = 4'b1100;
        #10 open = 1; #10 open = 0;

        // Enter correct password and press "Open"
        #10 Password_in = 4'b1010;
        #10 open = 1; #10 open = 0;

        // Press "Close" to lock again
        #10 close = 1; #10 close = 0;

        // Finish simulation
        #50 $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | Password_in: %b | open: %b | close: %b | LOCK_STATE: %b | Current state: %0d",
                 $time, Password_in, open, close, LOCK_STATE, uut.current_state);
    end

endmodule

