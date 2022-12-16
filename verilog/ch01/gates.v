module Nand(input a, b, output out);
  nand g1(out, a, b);
endmodule

module Not(input in, output out);
  Nand g1(in, in, out);
endmodule

module Or(input a, b, output out);
  Not g1(a, nota);
  Not g2(b, notb);
  Nand g3(nota, notb, out);
endmodule

module Xor(input a, b, output out);
  Nand g1(a, b, AnandB);
  Or   g2(a, b, AorB);
  And  g3(AnandB, AorB, out);
endmodule

module And(input a, b, output out);
  Nand g1(a, b, AnandB);
  Nand g2(AnandB, AnandB, out);
endmodule

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

module And16 (input[15:0] a,b , output[15:0] out);
  And g00(a[0],b[0],out[0]);
  And g01(a[1],b[1],out[1]);
  And g02(a[2],b[2],out[2]);
  And g03(a[3],b[3],out[3]);
  And g04(a[4],b[4],out[4]);
  And g05(a[5],b[5],out[5]);
  And g06(a[6],b[6],out[6]);
  And g07(a[7],b[7],out[7]);
  And g08(a[8],b[8],out[8]);
  And g09(a[9],b[9],out[9]);
  And g10(a[10],b[10],out[10]);
  And g11(a[11],b[11],out[11]);
  And g12(a[12],b[12],out[12]);
  And g13(a[13],b[13],out[13]);
  And g14(a[14],b[14],out[14]);
  And g15(a[15],b[15],out[15]);
  
endmodule

module Not16(input[15:0] in, output[15:0] out);
  Not g00(in[0],out[0]);
  Not g01(in[1],out[1]);
  Not g02(in[2],out[2]);
  Not g03(in[3],out[3]);
  Not g04(in[4],out[4]);
  Not g05(in[5],out[5]);
  Not g06(in[6],out[6]);
  Not g07(in[7],out[7]);
  Not g08(in[8],out[8]);
  Not g09(in[9],out[9]);
  Not g10(in[10],out[10]);
  Not g11(in[11],out[11]);
  Not g12(in[12],out[12]);
  Not g13(in[13],out[13]);
  Not g14(in[14],out[14]);
  Not g15(in[15],out[15]);
  
endmodule

module Or16(input[15:0] a, b, output[15:0] out);
  Or g00(a[0],b[0],out[0]);
  Or g01(a[1],b[1],out[1]);
  Or g02(a[2],b[2],out[2]);
  Or g03(a[3],b[3],out[3]);
  Or g04(a[4],b[4],out[4]);
  Or g05(a[5],b[5],out[5]);
  Or g06(a[6],b[6],out[6]);
  Or g07(a[7],b[7],out[7]);
  Or g08(a[8],b[8],out[8]);
  Or g09(a[9],b[9],out[9]);
  Or g10(a[10],b[10],out[10]);
  Or g11(a[11],b[11],out[11]);
  Or g12(a[12],b[12],out[12]);
  Or g13(a[13],b[13],out[13]);
  Or g14(a[14],b[14],out[14]);
  Or g15(a[15],b[15],out[15]);
endmodule

module Mux16(input[15:0] a,b,input sel, output[15:0] out);
    Mux g00(a[0],b[0],sel,out[0]);
    Mux g01(a[1],b[1],sel,out[1]);
    Mux g02(a[2],b[2],sel,out[2]);
    Mux g03(a[3],b[3],sel,out[3]);
    Mux g04(a[4],b[4],sel,out[4]);
    Mux g05(a[5],b[5],sel,out[5]);
    Mux g06(a[6],b[6],sel,out[6]);
    Mux g07(a[7],b[7],sel,out[7]);
    Mux g08(a[8],b[8],sel,out[8]);
    Mux g09(a[9],b[9],sel,out[9]);
    Mux g10(a[10],b[10],sel,out[10]);
    Mux g11(a[11],b[11],sel,out[11]);
    Mux g12(a[12],b[12],sel,out[12]);
    Mux g13(a[13],b[13],sel,out[13]);
    Mux g14(a[14],b[14],sel,out[14]);
    Mux g15(a[15],b[15],sel,out[15]);
endmodule

module Mux4Way16(input[15:0] a,b,c,d, input[1:0] sel, output[15:0] out);
    wire[15:0] muxab, muxcd;
    Mux16 g1(a, b, sel[0], muxab);
    Mux16 g2(c, d, sel[0], muxcd);
    Mux16 g3(muxab, muxcd, sel[1], out);
endmodule

module Mux8Way16(input[15:0] a,b,c,d,e,f,g,h,input[2:0] sel, output[15:0] out);
    wire[15:0] muxab, muxcd, muxef, muxgh, second1, second2;
    Mux16 g1(a, b, sel[0], muxab);
    Mux16 g2(c, d, sel[0], muxcd);
    Mux16 g3(e, f, sel[0], muxef);
    Mux16 g4(g, h, sel[0], muxgh);
    Mux16 g5(muxab, muxcd, sel[1], second1);
    Mux16 g6(muxef, muxgh, sel[1], second2);
    Mux16 g7(second1, second2, sel[2], out);
endmodule


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



