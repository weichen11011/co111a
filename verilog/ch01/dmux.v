`include "muxdmux.v"

module Dmux4Way(input in, input[1:0] sel, output a,b,c,d);
    wire x,y;
    Dmux g1(in,sel[1],x,y);
    Dmux g2(x,sel[0],a,b);
    Dmux g3(y,sel[0],c,d);
endmodule

module Dmux8Way(input in, input[2:0] sel, output a,b,c,d,e,f,g,h);
    wire x,y;
    Dmux g1(in,sel[2],x,y);
    Dmux4Way g2(x,sel[1:0],a,b,c,d);
    Dmux4Way g3(y,sel[1:0],e,f,g,h);
endmodule