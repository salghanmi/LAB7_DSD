module Control(
    input logic clk,
    input logic reset_n,
    input logic start,
    output logic load,
    output logic shift_en,
    output logic done,
    input logic [2:0] bit_counter // Counter input that tracks bit processing
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        LOAD = 3'b001,
        ADD = 3'b010,
        CHECK_DONE = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            IDLE:
                if (start)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            LOAD:
                next_state = ADD;
            ADD:
                next_state = CHECK_DONE;
            CHECK_DONE:
                if (bit_counter == 3'd4) // Assuming you are counting from 0 to 4
                    next_state = DONE;
                else
                    next_state = ADD;
            DONE:
                next_state = IDLE;
            default:
                next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        load = (state == LOAD);
        shift_en = (state == ADD);
        done = (state == DONE);
    end
endmodule
