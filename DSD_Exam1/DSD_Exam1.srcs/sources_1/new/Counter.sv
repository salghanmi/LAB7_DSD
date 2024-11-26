`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:33:35 PM
// Design Name: 
// Module Name: Counter
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

module Counter(
    input logic clk, 
    input logic reset, 
    output logic [13:0] count);


    // 14-bit counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else if (count == 14'd9999)
            count <= 0;
        else
            count <= count + 1;
    end
endmodule 