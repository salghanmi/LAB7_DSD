`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 01:28:08 PM
// Design Name: 
// Module Name: tb_overflow_8bits_Task1
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


module tb_overflow_8bits_Task1;
    reg clk;                     
    reg count;                
    reg overflow;  
    logic reset;   
    
     
Overflow_8bits_Task1 Task1_inst(
    .count(count),
    .clk(clk), 
    .reset(reset), 
    .overflow(overflow)
    ); 
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        $display("Starting 8 bits Overflow Detecting Testbench...");
        
        reset=1; 
        
        #5;
        reset =0; 
        #10;
        count = 1'b0;
        $display("Test 1: count= %b, Overflow= %b ", count, overflow);
        #10;
        count = 1'b1;
        $display("Test 2: count= %b, Overflow= %b ", count, overflow); 
        #10;       
        count = 1'b1;
        $display("Test 3: count= %b, Overflow= %b ", count, overflow);
                #12;       
        count = 1'b0;
        $display("Test 4: count= %b, Overflow= %b ", count, overflow);
//        #10;  
//        count = 8'b1111_1111;
//        $display("Test 2: count= %b, Overflow= %b ", count, overflow);
//        #10;  
//        count = 8'b0000_0000;
//        $display("Test 2: count= %b, Overflow= %b ", count, overflow);
//        #10;  
       
        $display("Testbench Completed.");
        $finish; // Stop the simulation
   end 
   
endmodule:tb_overflow_8bits_Task1 
