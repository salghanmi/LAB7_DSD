`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 05:22:19 PM
// Design Name: 
// Module Name: tb_Pattern_Detector
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


module tb_Pattern_Detector;
    logic clk;
    logic reset_n;
    logic load;
    logic [4:0] pattern;
    logic serial_in;
    logic pattern_match;

    Pattern_Detector uut(
        .clk(clk),
        .reset_n(reset_n),
        .load(load),
        .pattern(pattern),
        .serial_in(serial_in),
        .pattern_match(pattern_match)
    );

    always #10 clk = ~clk;
    initial begin
        clk = 0;
        reset_n = 0;
        load = 0;
        pattern = 5'b10101;
        serial_in = 0;
        #20 reset_n = 1;
        #20 load = 1; // Load the pattern
        #20 load = 0;

        #20 serial_in = 1;
        #20 serial_in = 0;
        #20 serial_in = 1;
        #20 serial_in = 0;
        #20 serial_in = 1; // output match here 

        $stop; 
    end

    initial begin
        $monitor("Time=%0t, reset_n=%b, pattern=%b, serial_in=%b, match=%b",
                 $time, reset_n, pattern, serial_in, pattern_match);
    end

endmodule

