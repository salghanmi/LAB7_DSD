`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 02:12:56 PM
// Design Name: 
// Module Name: tb_Detect_odd_ones_Task2
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


module tb_Detect_odd_ones_Task2;

    logic [7:0] d;
    logic out, clk;
    
 Detect_odd_ones_Task2 Task2_inst(
    .d(d), 
    .out(out)
    );
    
      initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        $display("Starting  Detecting  Odd Ones Testbench...");
       
        #10;   
        d = 8'b1111_0000;
        $display("Test 1: d= %b, out= %b ", d, out);
        #10;
        #10;   
        d = 8'b1111_0100;
        $display("Test 1: d= %b, out= %b ", d, out);
        #10; 
           #10;
        
        d = 8'b1111_1100;
        $display("Test 1: d= %b, out= %b ", d, out);
        #10;
                $display("Testbench Completed.");
        $finish; // Stop the simulation
   end 
    
endmodule
