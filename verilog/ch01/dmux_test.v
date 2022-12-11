`include "dmux.v"

module main;
    reg in;
    reg[2:0] sel;
    wire a,b,c,d,e,f,g,h,i,j,k,l;

    Dmux4Way g1(in,sel[1:0],a,b,c,d);
    Dmux8Way g2(in,sel[2:0],e,f,g,h,i,j,k,l);

    initial 
    begin
        $monitor("%4dns in =%b sel =%x a =%b b =%b c=%b d=%b\n e =%b, f =%b, g =%b, h =%b, i =%b, j =%b, k =%b, l =%b",
        $stime,in,sel,a,b,c,d,e,f,g,h,i,j,k,l);
        in =0;
        sel = 0;    
    end

    always #50 begin
        sel =sel+1; 
    end

    always #200 begin
        in = 1;
    end    

    initial #500 $finish;
endmodule