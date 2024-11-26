`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 05:20:23 PM
// Design Name: 
// Module Name: Pattern_Detector
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


module Pattern_Detector(
    input logic clk, 
    input logic reset_n,
    input logic load,
    input logic [4:0] pattern,
    input logic serial_in,
    output logic pattern_match
);

    logic [4:0] pattern_register;
    logic [4:0] shift_register;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            pattern_register <= 5'b0;
        else if (load)
            pattern_register <= pattern;
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            shift_register <= 5'b0;
        else
            shift_register <= {shift_register[3:0], serial_in};
    end

    always_comb begin
        pattern_match = (shift_register == pattern_register);
    end

endmodule

