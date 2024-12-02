`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:24:12 PM
// Design Name: 
// Module Name: Sequence_Detector_Task1
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


module Sequence_Detector_Task1( 
    input logic clk, 
    input logic reset, 
    input logic in_bit, 
    output logic detected, 
    output logic [3:0] count 

    );
    
    typedef enum logic [2:0] {
       IDLE,
       S1,
       S2,
       S3,
       S4
       } state_t;
       
state_t current_state, next_state;

logic [3:0] count_next; 


// ======== State transition on clock edge
always_ff @(posedge clk or posedge reset) begin
    if (reset)begin
        current_state <= IDLE;
        count <= 4'b0;
    end else begin
        current_state <= next_state;
        count <= count_next;
    end
    end 

    
//========= Next-state logic
always_comb begin

    case (current_state)
        IDLE:next_state = in_bit ? S1 : IDLE;
        S1:next_state = in_bit ? S2 : IDLE;
        S2:next_state = in_bit ? S2 : S3;
        S3:next_state = in_bit ? S4 : IDLE;
        S4:next_state = in_bit ? S2 : IDLE;

        default: next_state = IDLE;
    endcase
end


//// Output logic
always_comb begin

    detected = (current_state == S4);
    count_next= (current_state == S4)? (count + 4'b1) :  count;

end
    
endmodule
