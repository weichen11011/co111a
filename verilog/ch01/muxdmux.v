`include "./gate.v"

module Mux(input a, b, sel, output out);
    Not g1(sel,notsel);
    And g2(a,notsel,and1);
    And g3(sel,b,and2);
    Or  g4(and1,and2,out);
endmodule

module Dmux(input in, sel, output a, b); 
    Not g1(sel,notsel);
    And g2(notsel,in,a);
    And g3(sel,in,b);
endmodule