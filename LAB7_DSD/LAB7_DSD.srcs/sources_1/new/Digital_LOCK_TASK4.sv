
//`timescale 1ns / 1ps



//module Digital_LOCK_TASK4(    
//    input logic clk, 
//    input logic reset, 
//    input logic [3:0] Password_in, 
//    input logic open,
//    input logic close,
//    output logic LOCK_STATE,
//    output logic FAILED_STATE // Indicates the system is in Failed state
//);

//    // Parameters
//    parameter [3:0] Password = 4'b1111; // Fixed password
//    parameter integer TIME_10_SEC = 100_000_000 * 10; // 10 seconds in clock cycles

//    // State declaration
//    typedef enum logic [1:0] {
//        Locked,      // Locked state
//        Unlocked,    // Unlocked state
//        Failed       // Failed state
//    } state_t;

//    state_t current_state, next_state;

//    // Counters
//    logic [1:0] fail_count;  // Tracks failed attempts
//    logic [31:0] timer;      // Timer for Failed state

//    // Rising edge detection for `open`
//    logic open_prev, open_request;
//    always_ff @(posedge clk or negedge reset) begin
//        if (!reset) begin
//            open_prev <= 1'b0;
//            open_request <= 1'b0;
//        end else begin
//            open_request <= (open && !open_prev); // Detect rising edge
//            open_prev <= open;
//        end
//    end

//    // State transition
//    always_ff @(posedge clk or negedge reset) begin
//        if (!reset) begin
//            current_state <= Locked;
//            fail_count <= 0;
//            timer <= 0;
//        end else begin
//            current_state <= next_state;

//            // Timer in Failed state
//            if (current_state == Failed)
//                timer <= timer + 1;
//            else
//                timer <= 0;

//            // Increment fail count for incorrect password
//            if (current_state == Locked && open_request && Password_in != Password)
//                fail_count <= fail_count + 1;
//            else if (current_state == Unlocked || current_state == Failed)
//                fail_count <= 0;
//        end
//    end

//    // Next-state logic
//    always_comb begin
//        next_state = current_state; // Default: stay in current state

//        case (current_state)
//            Locked: begin
//                if (open_request && Password_in == Password)
//                    next_state = Unlocked; // Correct password
//                else if (fail_count >= 2)
//                    next_state = Failed; // Too many failed attempts
//            end

//            Unlocked: begin
//                if (close)
//                    next_state = Locked; // Close lock
//            end

//            Failed: begin
//                if (timer >= TIME_10_SEC)
//                    next_state = Locked; // Timeout, return to Locked
//            end
//        endcase
//    end

//    // Output logic
//    always_comb begin
//        LOCK_STATE = (current_state == Unlocked); // 1 for Unlocked
//        FAILED_STATE = (current_state == Failed); // 1 for Failed
//    end

//endmodule

`timescale 1ns / 1ps

module Digital_LOCK_TASK4(    
    input logic clk, 
    input logic reset, 
    input logic [3:0] Password_in, 
    input logic open,
    input logic close,
    output logic LOCK_STATE,
    output logic FAILED_STATE // Indicates the system is in Failed state
);

    // Parameters
    parameter [3:0] Password = 4'b1111; // Fixed password
    parameter integer TIME_10_SEC = 100_000_000 * 10; // 10 seconds in clock cycles

    // State declaration
    typedef enum logic [1:0] {
        Locked,      // Locked state
        Unlocked,    // Unlocked state
        Failed       // Failed state
    } state_t;

    state_t current_state, next_state;

    // Counters
    logic [1:0] fail_count;  // Tracks failed attempts
    logic [31:0] timer;      // Timer for Failed state

    // Rising edge detection for `open`
    logic open_prev, open_request;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            open_prev <= 1'b0;
            open_request <= 1'b0;
        end else begin
            open_request <= (open && !open_prev); // Detect rising edge
            open_prev <= open;
        end
    end

    // State transition and fail count update
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            current_state <= Locked;
            fail_count <= 2'b00; // Reset fail count
            timer <= 0;          // Reset timer
        end else begin
            current_state <= next_state;

            // Timer in Failed state
            if (current_state == Failed)
                timer <= timer + 1;
            else
                timer <= 0;

            // Increment fail count only on incorrect password and open_request
            if (current_state == Locked && open_request && Password_in != Password && fail_count < 2'b11)
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
                if (open_request && Password_in == Password)
                    next_state = Unlocked; // Correct password
                else if (fail_count == 2'b10 && open_request && Password_in != Password)
                    next_state = Failed; // Too many failed attempts (3rd incorrect)
            end

            Unlocked: begin
                if (close)
                    next_state = Locked; // Close lock
            end

            Failed: begin
                if (timer >= TIME_10_SEC)
                    next_state = Locked; // Timeout, return to Locked
            end
        endcase
    end

    // Output logic
    always_comb begin
        LOCK_STATE = (current_state == Unlocked); // 1 for Unlocked
        FAILED_STATE = (current_state == Failed); // 1 for Failed
    end

endmodule
