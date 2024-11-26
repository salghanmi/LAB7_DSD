`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 04:33:35 PM
// Design Name: 
// Module Name: Radar_pulse_Generator
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

module Radar_pulse_Generator(
    input logic clk, 
    input logic reset,
    output logic trigger_out 
);

    logic [13:0] count;
    logic pulse_high1, pulse_high2, pulse_high;
//    assign pulse_high1=0; 
//    assign pulse_high2=0; 

    Counter counter_inst(
        .clk(clk), 
        .reset(reset), 
        .count(count)
    );
    
    Comparator Comp1(
        .A(14'd500),
        .count(count), 
        .reset(reset),
        .pulse_high(pulse_high1)
    );
    
    Comparator Comp2(
        .A(14'd1000),
        .count(count), 
        .reset(reset),
        .pulse_high(pulse_high2)
    );
    
    assign pulse_high = pulse_high1 | pulse_high2;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            trigger_out <= 1; 
        else if (pulse_high)
            trigger_out <= ~trigger_out; 
    end
endmodule

