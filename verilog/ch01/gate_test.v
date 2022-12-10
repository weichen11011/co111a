`include "./gate.v"

module main;
reg a, b;
wire anot, anandb, aanb, aorb, axorb;

Not  g1(a, anot);
Nand g2(a, b, anandb);
And  g3(a, b, aandb);
Or   g4(a, b, aorb);
Xor  g5(a, b, axorb);

initial
begin
  $monitor("%4dns b=%d a=%d anot=%d anandb=%d aandb=%d aorb=%d axorb=%d", $stime, b, a, anot, anandb, aandb, aorb, axorb);
  a  = 0;
  b  = 0;
end

always #50 begin
  a = a+1;
end

always #100 begin
  b = b+1;
end

initial #500 $finish;

endmodule



