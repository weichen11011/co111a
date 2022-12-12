`include "../ch01/gate.v"
`include "../ch01/gate16.v"
`include "./add.v"


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