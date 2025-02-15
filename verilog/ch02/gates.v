`include "../ch01/gates.v"

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

module Add16(input[15:0] a,b, output[15:0] out);
    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;

    HalfAdder g00(a[0],b[0],out[0],c0);
    FullAdder g01(a[1],b[1],c0,out[1],c1);
    FullAdder g02(a[2],b[2],c1,out[2],c2);
    FullAdder g03(a[3],b[3],c2,out[3],c3);
    FullAdder g04(a[4],b[4],c3,out[4],c4);
    FullAdder g05(a[5],b[5],c4,out[5],c5);
    FullAdder g06(a[6],b[6],c5,out[6],c6);
    FullAdder g07(a[7],b[7],c6,out[7],c7);
    FullAdder g08(a[8],b[8],c7,out[8],c8);
    FullAdder g09(a[8],b[9],c8,out[9],c9);
    FullAdder g10(a[10],b[10],c9,out[10],c10);
    FullAdder g11(a[11],b[11],c10,out[11],c11);
    FullAdder g12(a[12],b[12],c11,out[12],c12);
    FullAdder g13(a[13],b[13],c12,out[13],c13);
    FullAdder g14(a[14],b[14],c13,out[14],c14);
    FullAdder g15(a[15],b[15],c14,out[15],c15);
    
endmodule

module Inc16(input[15:0] in, output[15:0] out);
    wire[15:0] b =16'b0000000000000001;
    Add16 g1(in,16'h1,out);
endmodule

module Or8Way(input[7:0] in, output out);
  Or g1(in[7], in[6], or76);
  Or g2(in[5], in[4], or54);
  Or g3(in[3], in[2], or32);
  Or g4(in[1], in[0], or10);
  Or g5(or76, or54, or74);
  Or g6(or32, or10, or30);
  Or g7(or74, or30, out);
endmodule

module ALU(input[15:0] x,y, input zx,nx,zy,ny,f,no,output[15:0] out ,output zr,ng);
    wire[15:0] x1, notx1, x2, y1, noty1, y2, andxy, addxy, o1, noto1, o2;
    wire orLow, orHigh, notzr;

    // zx
    Mux16 g1(x,  16'b0, zx, x1); 

    // nx   
    Not16 g2(x1, notx1);
    Mux16 g3(x1, notx1, nx, x2);   

    // zy
    Mux16 g4(y,  16'b0, zy, y1);

    // ny
    Not16 g5(y1, noty1);
    Mux16 g6(y1, noty1, ny, y2); 

    //f
    Add16 g7(x2, y2, addxy);       
    And16 g8(x2, y2, andxy);       
    Mux16 g9(andxy, addxy, f, o1);

    // no
    Not16 g10(o1, noto1);
    Mux16 g11(o1, noto1, no, o2);  
    And16 g12(o2, o2, out); 

    // zr
    Or8Way g13(out[7:0],  orLow);  
    Or8Way g14(out[15:8], orHigh);

    Or    g15(orLow, orHigh, notzr); 
    Not   g16(notzr, zr);            
    And   g17(o2[15], o2[15], ng);   

    // ng
    And16 g18(o2, o2, out);

    
endmodule
