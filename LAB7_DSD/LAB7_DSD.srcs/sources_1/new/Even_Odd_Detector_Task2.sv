`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 02:29:32 PM
// Design Name: 
// Module Name: Even_Odd_Detector_Task2
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


module Even_Odd_Detector_Task2(
    input logic clk, 
    input logic reset, 
    input logic in_bit, 
    output logic Zero_even_detected, 
    output logic One_even_detect  
    );
    
 typedef enum logic [2:0] {
       S1,// Zero odd , 1 even 
       S2,// Zero odd , 1 odd
       S3,// zero even , 1, even 
       S4// zero even , 1 odd 
       } state_t;
       
       state_t current_state, next_state;
       

// ======== State transition on clock edge
always_ff @(posedge clk or posedge reset) begin
    if (reset)begin
        current_state <= S1;
    end else begin
        current_state <= next_state;
        
    end
    end 

    
//========= Next-state logic
always_comb begin
    case (current_state)
        S1:next_state = in_bit ? S2 : S3;
        S2:next_state = in_bit ? S1 : S4;
        S3:next_state = in_bit ? S4 : S1;
        S4:next_state = in_bit ? S3 : S2;
        default: next_state = S1;
    endcase
end


//// Output logic
always_comb begin

    Zero_even_detected = ((current_state == S4)||(current_state == S3));
    One_even_detect= ((current_state == S1)||(current_state == S3));;

end
    
endmodule
