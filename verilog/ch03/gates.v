`include "../ch02/gates.v"

module DFF(input in, clock, output out);
    reg q;
    assign out = q;

    always @(posedge clock) begin
        q = in;
    end
endmodule

module Bit(input in, clock,load, output out);
    wire mux;
    Mux g1(out,in,load,mux);
    DFF g2(mux,clock,out);
endmodule

module Register(input[15:0] in, input clock,load, output[15:0] out);
    Bit g00(in[15],clock,load,out[15]);
    Bit g01(in[14],clock,load,out[14]);
    Bit g02(in[13],clock,load,out[13]);
    Bit g03(in[12],clock,load,out[12]);
    Bit g04(in[11],clock,load,out[11]);
    Bit g05(in[10],clock,load,out[10]);
    Bit g06(in[9],clock,load,out[9]);
    Bit g07(in[8],clock,load,out[8]);
    Bit g08(in[7],clock,load,out[7]);
    Bit g09(in[6],clock,load,out[6]);
    Bit g10(in[5],clock,load,out[5]);
    Bit g11(in[4],clock,load,out[4]);
    Bit g12(in[3],clock,load,out[3]);
    Bit g13(in[2],clock,load,out[2]);
    Bit g14(in[1],clock,load,out[1]);
    Bit g15(in[0],clock,load,out[0]);

endmodule

module PC(input[15:0] in, input clock, load,inc,reset,output[15:0] out);
    wire[15:0] out1,out2,out3,out4,out5;

    //Or g1(load, inc, or1);
    //Or g2(or1,reset,or2);
    Inc16 g3(out5,out4);
    And16 g4(out5,out5,out);

    Mux16 g5(out5,out4,inc,out3);
    Mux16 g6(out3,in,load,out2);
    Mux16 g7(out2,16'b0,reset,out1);

    Register g8(out1,clock,1'b1,out5);
    
endmodule

module RAM8(input[15:0] in, input clock, load, input[2:0] address, output[15:0] out);
    wire a,b,c,d,e,f,g,h;
    wire[15:0] out1,out2,out3,out4,out5,out6,out7,out8;
    Dmux8Way g1(load,address,a,b,c,d,e,f,g,h);

    Register g2(in,clock,a,out1);
    Register g3(in,clock,b,out2);
    Register g4(in,clock,c,out3);
    Register g5(in,clock,d,out4);
    Register g6(in,clock,e,out5);
    Register g7(in,clock,f,out6);
    Register g8(in,clock,g,out7);
    Register g9(in,clock,h,out8);

    Mux8Way16 g10(out1,out2,out3,out4,out5,out6,out7,out8,address,out);
endmodule

module RAM64(input[15:0] in, input clock,load, input[5:0] address, output[15:0] out);
    wire a,b,c,d,e,f,g,h;
    wire[15:0] out1,out2,out3,out4,out5,out6,out7,out8;
    Dmux8Way g1(load,address[5:3],a,b,c,d,e,f,g,h);

    RAM8 g2(in,clock,a,address[2:0],out1);
    RAM8 g3(in,clock,b,address[2:0],out2);
    RAM8 g4(in,clock,c,address[2:0],out3);
    RAM8 g5(in,clock,d,address[2:0],out4);
    RAM8 g6(in,clock,e,address[2:0],out5);
    RAM8 g7(in,clock,f,address[2:0],out6);
    RAM8 g8(in,clock,g,address[2:0],out7);
    RAM8 g9(in,clock,h,address[2:0],out8);

    Mux8Way16 g10(out1,out2,out3,out4,out5,out6,out7,out8,address[5:3],out);
endmodule
/*
module RAM512(input[15:0] in, input clock,load, input[8:0] address, output[15:0] out);
    wire a,b,c,d,e,f,g,h;
    wire[15:0] out1,out2,out3,out4,out5,out6,out7,out8;
    Dmux8Way g1(load,address[8:6],a,b,c,d,e,f,g,h);

    RAM64 g2(in,clock,address[5:0],a,out1);
    RAM64 g3(in,clock,address[5:0],b,out2);
    RAM64 g4(in,clock,address[5:0],c,out3);
    RAM64 g5(in,clock,address[5:0],d,out4);
    RAM64 g6(in,clock,address[5:0],e,out5);
    RAM64 g7(in,clock,address[5:0],f,out6);
    RAM64 g8(in,clock,address[5:0],g,out7);
    RAM64 g9(in,clock,address[5:0],h,out8);

    Mux8Way16 g10(out1,out2,out3,out4,out5,out6,out7,out8,address[8:6],out);

endmodule

module RAM4K(input[15:0] in, input clock,load, input[11:0] address, output[15:0] out);
    wire a,b,c,d,e,f,g,h;
    wire[15:0] out1,out2,out3,out4,out5,out6,out7,out8;
    Dmux8Way g1(load,address[11:9],a,b,c,d,e,f,g,h);

    RAM512 g2(in,clock,address[8:0],a,out1);
    RAM512 g3(in,clock,address[8:0],b,out2);
    RAM512 g4(in,clock,address[8:0],c,out3);
    RAM512 g5(in,clock,address[8:0],d,out4);
    RAM512 g6(in,clock,address[8:0],e,out5);
    RAM512 g7(in,clock,address[8:0],f,out6);
    RAM512 g8(in,clock,address[8:0],g,out7);
    RAM512 g9(in,clock,address[8:0],h,out8);

    Mux8Way16 g10(out1,out2,out3,out4,out5,out6,out7,out8,address[11:9],out);

endmodule

module RAM16K(input[15:0] in, input clock,load, input[13:0] address, output[15:0] out);
    wire a,b,c,d,e,f,g,h;
    wire[15:0] out1,out2,out3,out4,out5,out6,out7,out8;
    Dmux8Way g1(load,address[13:11],a,b,c,d,e,f,g,h);

    RAM4K g2(in,clock,address[10:0],a,out1);
    RAM4K g3(in,clock,address[10:0],b,out2);
    RAM4K g4(in,clock,address[10:0],c,out3);
    RAM4K g5(in,clock,address[10:0],d,out4);

    Mux8Way16 g10(out1,out2,out3,out4,out5,out6,out7,out8,address[13:11],out);

endmodule
*/

module ROM32K(input[14:0] address, output[15:0] out);
    reg[15:0] m[0:2**15-1];

    assign out = m[address];
endmodule

module RAM8K(input[15:0] in, input clock, load, input[12:0] address, output[15:0] out);
    reg[15:0] m[0:2**13-1];

    assign out = m[address];

    always @(posedge clock) begin
    if (load) m[address] = in;
    end
endmodule

module RAM16K(input[15:0] in, input clock, load, input[13:0] address, output[15:0] out);
    reg[15:0] m[0:2**14-1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule


