`include "./gates.v"

module main;
reg  [15:0] a,b;
wire [15:0] anot, aandb, aorb;

Not16  g1(a, anot);
And16  g2(a, b, aandb);
Or16   g3(a, b, aorb);

initial
begin
  $monitor("a  =%b b  =%b not=%b and=%b or =%b", a, b, anot, aandb, aorb);
  a  = 16'b1011;
  b  = 16'b0101;
  $finish;
end

endmodule
