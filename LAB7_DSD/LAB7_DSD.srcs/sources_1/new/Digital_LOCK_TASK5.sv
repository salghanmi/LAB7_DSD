`timescale 1ns / 1ps

module Digital_LOCK_TASK5(    
    input logic clk, 
    input logic reset, 
    input logic [3:0] Password_in, 
    input logic open,
    input logic close,
    input logic change_password, // New button for changing the password
    output logic LOCK_STATE,
    output logic FAILED_STATE, // Indicates the system is in Failed state
    output logic EDIT_STATE    // Indicates the system is in Password Edit mode
);

    parameter integer TIME_10_SEC = 100_000_000 * 10; // 10 seconds in clock cycles

    typedef enum logic [1:0] {
        Locked,      // Locked state
        Unlocked,    // Unlocked state
        Failed,      // Failed state
        Editing      // Editing (Change Password) state
    } state_t;

    state_t current_state, next_state;

    // Registers for password
    logic [3:0] stored_password = 4'b1111; // Initially set to 1111
    logic [1:0] fail_count;               // Tracks failed attempts
    logic [31:0] timer;                   // Timer for Failed state

    // Rising edge detection for `open` and `change_password`
    logic open_prev, open_request;
    logic change_prev, change_request;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            open_prev <= 1'b0;
            open_request <= 1'b0;
            change_prev <= 1'b0;
            change_request <= 1'b0;
        end else begin
            open_request <= (open && !open_prev);           // Detect rising edge of `open`
            open_prev <= open;
            change_request <= (change_password && !change_prev); // Detect rising edge of `change_password`
            change_prev <= change_password;
        end
    end

    // State transition and password update
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            current_state <= Locked;
            fail_count <= 2'b00;
            timer <= 0;
        end else begin
            current_state <= next_state;

            // Timer in Failed state
            if (current_state == Failed)
                timer <= timer + 1;
            else
                timer <= 0;

            // Update password in Editing state
            if (current_state == Editing && change_request)
                stored_password <= Password_in;

            // Increment fail count for incorrect password
            if (current_state == Locked && open_request && Password_in != stored_password && fail_count < 2'b11)
                fail_count <= fail_count + 1;
            else if (current_state == Unlocked || current_state == Failed)
                fail_count <= 2'b00; // Reset fail count
        end
    end

    // Next-state logic
    always_comb begin
        next_state = current_state; // Default: stay in current state

        case (current_state)
            Locked: begin
                if (open_request && Password_in == stored_password)
                    next_state = Unlocked; // Correct password
                else if (fail_count == 2'b10 && open_request && Password_in != stored_password)
                    next_state = Failed; // Too many failed attempts
            end

            Unlocked: begin
                if (close)
                    next_state = Locked; // Close lock
                else if (change_request)
                    next_state = Editing; // Enter password change mode
            end

            Failed: begin
                if (timer >= TIME_10_SEC)
                    next_state = Locked; // Timeout, return to Locked
            end

            Editing: begin
                if (change_request) // Confirm new password
                    next_state = Unlocked; // Return to Unlocked
            end
        endcase
    end

    // Output logic
    always_comb begin
        LOCK_STATE = (current_state == Unlocked); // 1 for Unlocked
        FAILED_STATE = (current_state == Failed); // 1 for Failed
        EDIT_STATE = (current_state == Editing);  // 1 for Editing
    end

endmodule
