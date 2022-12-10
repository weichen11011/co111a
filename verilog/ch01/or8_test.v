`include "./or8.v"

module Or8way_test;
reg [7:0]a;
wire or8way;

Or8Way g1(a,or8way);

initial
begin
  $monitor("a  =%b or8way =%b", a, or8way);
  a  = 8'b0011;
  $finish;

end  

endmodule


