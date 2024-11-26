`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:51:36 PM
// Design Name: 
// Module Name: tb_Radar_pulse_Generator
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


module tb_Radar_pulse_Generator;
    logic clk;
    logic reset;
    logic trigger_out;
    Radar_pulse_Generator dut(
        .clk(clk),
        .reset(reset),
        .trigger_out(trigger_out)
    );

    always #5 clk = ~clk;  

    // Test sequence
    initial begin
        clk = 0;       
        reset = 1;      
        #40;           

        reset = 0;     
        #1000;          // Run simulation for 1000 ns 

        reset = 1;      
        #20;            
        reset = 0;      
        #500;           

        $stop;          
    end
    initial begin
        $monitor("Time = %t, reset = %b, trigger_out = %b", $time, reset, trigger_out);
    end

endmodule


