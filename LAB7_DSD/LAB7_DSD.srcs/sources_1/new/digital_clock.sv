`timescale 1ns / 1ps

module digital_clock(
    input clk,        // 1 Hz clock signal
    input reset,      // Active high reset
    output reg [3:0] hours,    // 1-12
    output reg [5:0] minutes,  // 0-59
    output reg [5:0] seconds   // 0-59
);
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COUNTING = 2'b01,
        RESET = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Internal register for the counter (counts total seconds)
    reg [15:0] counter; // 16-bit counter to handle up to 43,199 seconds

    // FSM: State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= RESET;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM: Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset)
                    next_state = RESET;
                else
                    next_state = COUNTING;
            end
            COUNTING: begin
                if (reset)
                    next_state = RESET;
                else
                    next_state = COUNTING;
            end
            RESET: begin
                next_state = COUNTING;
            end
            default: next_state = IDLE;
        endcase
    end

    // FSM: Output logic and counter handling
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            seconds <= 0;
            minutes <= 0;
            hours <= 12; // Initialize to 12:00:00
        end else begin
            case (current_state)
                IDLE: begin
                    // Do nothing in IDLE
                end
                COUNTING: begin
                    // Increment the counter
                    if (counter == 43199) // 12 hours in seconds
                        counter <= 0;    // Reset counter after 12 hours
                    else
                        counter <= counter + 1;

                    // Calculate hours, minutes, and seconds from counter
                    seconds <= counter % 60;                 // Modulo for seconds
                    minutes <= (counter / 60) % 60;          // Divide by 60 for minutes, modulo 60
                    hours <= ((counter / 3600) % 12) + 1;    // Divide by 3600 for hours, modulo 12, +1 for 1-12 range
                end
                RESET: begin
                    // Reset the time to 12:00:00
                    counter <= 0;
                    seconds <= 0;
                    minutes <= 0;
                    hours <= 12;
                end
            endcase
        end
    end
endmodule

