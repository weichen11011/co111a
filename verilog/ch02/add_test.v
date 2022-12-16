`include "./gates.v"

module main;
    reg[15:0] a,b;
    wire [15:0] add16, inc16;

    Add16 g1(a,b,add16);
    Inc16 g2(a,inc16);

    initial
    begin
        $monitor("%4dns a =%b b =%b add16 =%b inc16 =%b",$stime,a,b,add16,inc16);
        a =16'b0;
        b =16'b0;    
    end

    initial #50 begin
        a =16'b0000000000000000;
        b =16'b1111111111111111;
    end

    initial #100 begin
        a =16'b1111111111111111;
        b =16'b1111111111111111;
    end

    initial #150 begin
        a =16'b1010101010101010;
        b =16'b0101010101010101;
    end

    initial #200 $finish;
endmodule