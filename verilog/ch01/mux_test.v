`include "./mux.v"

module main;
    reg[15:0] a,b,c,d,e,f,g,h;
    reg[2:0] sel;
    wire[15:0] mux, mux4, mux8;

    Mux16 g1(a,b,sel[0],mux);
    Mux4Way16 g2(a,b,c,d,sel[1:0],mux4);
    Mux8Way16 g3(a,b,c,d,e,f,g,h,sel[2:0],mux8);

    initial 
    begin
        $monitor("%4dns sel =%d mux =%x mux4 =%x mux8 =%x",$stime,sel,mux,mux4,mux8);
        a =16'h0;
        b =16'h1;
        c =16'h2;
        d =16'h3;
        e =16'h4;
        f =16'h5;
        g =16'h6;
        h =16'h7;
        sel =0; 
    end

    always #50 begin
        sel = sel+1;
    end
    
    initial #500 $finish;
endmodule