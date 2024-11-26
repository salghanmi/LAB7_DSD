`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 02:35:16 PM
// Design Name: 
// Module Name: tb_Adder_8bits_Task3
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


module tb_Adder_8bits_Task3;
    logic [7:0] A, B, sum; 
    logic c_in, c_out, clk;

Adder_8bits_Task3 Task3_inst( 
    .A(A), 
    .B(B), 
    .c_in(c_in), 
    .c_out(c_out), 
    .sum(sum) );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end
    initial begin
        $display("Starting 8 bits Adder Testbench...");
         #5;
         #10;
        A = 8'b0000_0011; B= 8'b0000_1111; c_in=1'b0;
        $display("Test 1: A= %b, B= %b , Sum= %b, c_in=%d, c_out=%d", A, B, sum, c_in, c_out);
        #10;
        A = 8'b0010_0011; B= 8'b1000_1111; c_in=1'b1;
        $display("Test 1: A= %b, B= %b , Sum= %b, c_in=%d, c_out=%d", A, B, sum, c_in, c_out);
        #10;
        
        $finish;
        
        end 
endmodule
