`include "./gates.v"

module RegisterTestbench;

reg         clock = 0;
reg         enable = 1;
reg  [15:0] value_in;
wire [15:0] value_out;

always #1 clock = !clock;

Register r(value_in, clock, enable, value_out);

initial begin
    //These events must be in chronological order.
    # 5 value_in = 31;
    # 5 value_in = 127;
    # 5 enable = 0;
    # 5 value_in = 1023;
    # 5 $finish;
end
endmodule