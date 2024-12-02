`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 03:57:27 PM
// Design Name: 
// Module Name: Digital_LOCK_FPGA
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



module Digital_LOCK_FPGA(
   input wire CLK100MHZ,    // using the same name as pin names
   input wire BTNC,BTNL, 
   input wire CPU_RESETN,   
   input logic [3:0] SW ,
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN  
            // Switches for password input

);

    logic LOCK_STATE, btn_open, btn_close, reset, clk; // Lock state: 1 = Unlocked, 0 = Locked
    assign btn_open = BTNC;
    assign btn_close = BTNL; 
    assign reset = CPU_RESETN;
    assign clk= CLK100MHZ;
    // Instantiate the Digital Lock FSM
    Digital_Lock_Task3 lock_fsm (
        .clk(clk),
        .reset(reset),
        .Password_in(SW),       // Use switches as password input
        .open(btn_open),        // Use open button
        .close(btn_close),      // Use close button
        .LOCK_STATE(LOCK_STATE) // Output lock state
    );

   // Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7]; 
assign digits[0] =(LOCK_STATE == 1'b1) ? 4'b0000 : 4'b1100;;
assign digits[1]= SW[3:0];
assign digits[2] = 4'b1111;
assign digits[3] = 4'b1111;
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = 4'b1111;

sev_seg_controller ssc(.clk(clk),.resetn(~reset),.digits(digits),.Seg(Seg),  .AN(AN));


assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs

endmodule : Digital_LOCK_FPGA

