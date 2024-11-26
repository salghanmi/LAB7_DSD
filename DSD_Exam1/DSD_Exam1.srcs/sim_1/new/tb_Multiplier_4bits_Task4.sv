`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:23:29 PM
// Design Name: 
// Module Name: tb_Multiplier_4bits_Task4
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


module tb_Multiplier_4bits_Task4;
    logic [3:0] A;
    logic [3:0] B;
    logic [7:0] P;

    Multiplier_4bits_Task4 uut(
        .A(A), 
        .B(B), 
        .P(P)
    );

    initial begin
        A = 4'b0011; B = 4'b0101;
        #10; 
        A = 4'b1100; B = 4'b1010;
        #10;
        A = 4'b1111; B = 4'b1111;
        #10; 
        A = 4'b0000; B = 4'b1111;
        #10; 
        A = 4'b0101; B = 4'b0101;
        #10; 

        $stop;
    end

endmodule

