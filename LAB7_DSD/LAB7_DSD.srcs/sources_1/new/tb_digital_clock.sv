

module tb_digital_clock;
    reg clk, reset;
    wire [3:0] hours;
    wire [5:0] minutes, seconds;

    digital_clock uut (
        .clk(clk),
        .reset(reset),
        .hours(hours),
        .minutes(minutes),
        .seconds(seconds)
    );

    // Generate a 1 Hz clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        reset = 1; 
        #10 reset = 0; 

        // Simulate the clock running for some time
        #600 $display("After 10 minutes: %0d:%0d:%0d", hours, minutes, seconds);

        // Simulate additional time
        #18000; // Simulate for 5 more hours
        $display("After 5 hours: %0d:%0d:%0d", hours, minutes, seconds);

        // Reset the clock again
        reset = 1;
        #10 reset = 0;

        #1200 $stop;
    end
endmodule
