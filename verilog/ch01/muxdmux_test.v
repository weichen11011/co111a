`include "./muxdmux.v"

module main;
    reg sel;
    wire mux, dmux0, dmux1;

    Mux g1(1'b0,1'b1,sel,mux);
    Dmux g2(1'b1,sel,dmux0,dmux1);

    initial 
    begin
        $monitor("%4dns sel =%b mux =%d dmux0 =%d dmux1 =%d",$stime,sel,mux,dmux0,dmux1);
        sel =0;
    end

    always #100 begin
        sel = sel+1;
    end


    initial #200 $finish;
endmodule