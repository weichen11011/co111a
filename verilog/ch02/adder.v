`include "./gate.v"

module HalfAdder(input a,b,output sum,carry);
    Xor g1(a,b,sum);
    And g2(a,b,carry);
endmodule

module FullAdder(input a,b,c, output sum, carry);
    wire ha1,ha2,ha3;
    HalfAdder g1(a,b,ha1,ha2);
    HalfAdder g2(ha1,c,sum,ha3);
    Or g3(ha2,ha3,carry);
endmodule