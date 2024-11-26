module FullAdder(
    input logic A,
    input logic B,
    input logic Cin,
    output logic Sum,
    output logic Cout
);
    assign {Cout, Sum} = A + B + Cin;
endmodule


