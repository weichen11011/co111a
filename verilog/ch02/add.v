`include "./adder.v"

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
    Add16 g1(in,b,out);
endmodule