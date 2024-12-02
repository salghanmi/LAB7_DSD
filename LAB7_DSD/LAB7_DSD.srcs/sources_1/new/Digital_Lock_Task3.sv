`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 03:36:11 PM
// Design Name: 
// Module Name: Digital_Lock_Task3
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


module Digital_Lock_Task3(    
    input logic clk, 
    input logic reset, 
    input logic [3:0] Password_in, 
    input logic open,
    input logic close,
    output logic LOCK_STATE
);

    // Fixed password register
    localparam [3:0] Password = 4'b1111;// Example fixed password

    // State declaration
    typedef enum logic [1:0] {
        Locked, // Locked state
        Unlocked  // Unlocked state
    } state_t;

    state_t current_state, next_state;

    // ======== State transition on clock edge
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            current_state <= Locked; // Reset to Locked state
        end else begin
            current_state <= next_state;        
        end
    end

    // ========= Next-state logic
    always_comb begin
        case (current_state)
            Locked: begin
                // Stay in Locked state unless open button is pressed and password matches
                if (open && (Password_in == Password))
                    next_state = Unlocked; // Move to Unlocked state
                else
                    next_state = Locked; // Stay in Locked state
            end

            Unlocked: begin
                // Stay in Unlocked state until close button is pressed
                if (close)
                    next_state = Locked; // Move back to Locked state
                else
                    next_state = Unlocked; // Stay in Unlocked state
            end

            default: next_state = Locked; // Default state (Locked)
        endcase
    end

    // ========= Output logic
    always_comb begin
        // LOCK_STATE: 0 for Locked, 1 for Unlocked
        LOCK_STATE = (current_state == Unlocked);
    end

endmodule

