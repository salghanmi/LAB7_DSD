


module Adder_8bits_Task3( 
    input logic [7:0] A, 
    input logic [7:0] B, 
    input logic c_in, 
    output logic c_out, 
    output logic [7:0] sum );

logic c_temp;

Adder_4bits adder1(
    .A(A[3:0]), 
    .B(B[3:0]), 
    .c_in(c_in), 
    .c_out(c_temp), 
    .sum(sum[3:0])
    );

Adder_4bits adder2(
    .A(A[7:4]), 
    .B(B[7:4]), 
    .c_in(c_temp), 
    .c_out(c_out), 
    .sum(sum[7:4])
    );    
    
    
endmodule 