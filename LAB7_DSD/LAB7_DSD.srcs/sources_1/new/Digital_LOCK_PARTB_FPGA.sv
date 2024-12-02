`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 09:39:15 PM
// Design Name: 
// Module Name: Digital_LOCK_PARTB_FPGA
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


module Digital_LOCK_PARTB_FPGA(
    input wire CLK100MHZ,    // System clock
    input wire BTNC,         // Open button
    input wire BTNL,         // Close button
    input wire CPU_RESETN,   // Reset button (active low)
    input logic [3:0] SW,    // Switches for password input
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment segments
    output wire [7:0] AN     // Seven-segment anodes
);

    // Internal signals
    logic LOCK_STATE, FAILED_STATE, btn_open, btn_close, reset, clk;
    assign btn_open = BTNC;
    assign btn_close = BTNL; 
    assign reset = CPU_RESETN; // Active low reset
    assign clk = CLK100MHZ;

    // Instantiate the Digital Lock FSM
    Digital_LOCK_TASK4 lock_fsm (
        .clk(clk),
        .reset(reset),
        .Password_in(SW),         // Use switches as password input
        .open(btn_open),          // Use open button
        .close(btn_close),        // Use close button
        .LOCK_STATE(LOCK_STATE),  // Output lock state
        .FAILED_STATE(FAILED_STATE) // Output failed state

    );

    // Seven-segment Controller
    wire [6:0] Seg;
    logic [3:0] digits[0:7]; 
    always_comb begin
    case (1'b1) // Case matching active state
        FAILED_STATE: digits[0] = 4'b1111; // Display "F" for Failed
        LOCK_STATE: digits[0] = 4'b0000;   // Display "O" for Unlocked
        default: digits[0] = 4'b1100;      // Display "C" for Locked
    endcase
end

    // Define the first digit based on FSM state
//    always_comb begin
//        if (FAILED_STATE) begin
//            digits[0] = 4'b1111; // Display "F" for Failed
//        end else if (LOCK_STATE) begin
//            digits[0] = 4'b0000; // Display "O" for Unlocked
//        end else begin
//            digits[0] = 4'b1100; // Display "C" for Locked
//        end
//    end
//    assign digits[0] =(LOCK_STATE == 1'b1) ? 4'b0000 : 4'b1100;
//    assign digits[1] = (FAILED_STATE == 1'b1) ? 4'b1111 : 4'b0000;
    // Define remaining digits (optional custom logic for display)
    assign digits[1] = SW[3:0]; // Display password input
    assign digits[2] = 4'b1111; // Blank
    assign digits[3] = 4'b1111; // Blank
    assign digits[4] = 4'b1111; // Blank
    assign digits[5] = 4'b1111; // Blank
    assign digits[6] = 4'b1111; // Blank
    assign digits[7] = 4'b1111; // Blank

    // Seven-segment controller instantiation
    sev_seg_controller ssc (
        .clk(clk),
        .resetn(~reset),
        .digits(digits),
        .Seg(Seg),
        .AN(AN)
    );

    // Assign seven-segment display outputs
    assign CA = Seg[0];
    assign CB = Seg[1];
    assign CC = Seg[2];
    assign CD = Seg[3];
    assign CE = Seg[4];
    assign CF = Seg[5];
    assign CG = Seg[6];
    assign DP = 1'b1; // Turn off decimal point

endmodule

