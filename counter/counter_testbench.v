/*
To run:

iverilog -i test counter.v counter_testbench.v
vvp -n test

NOTES:
1. The -n causes the vvp to exit on $stop.  Normally
   we'd stay in the vvp environment.

Output:

At time                    0, value = xx (x)
At time                   17, value = 00 (0)
At time                   35, value = 01 (1)
At time                   45, value = 02 (2)
At time                   55, value = 03 (3)
At time                   57, value = 00 (0)
At time                   75, value = 01 (1)
At time                   85, value = 02 (2)
At time                   95, value = 03 (3)
At time                  105, value = 04 (4)
At time                  115, value = 05 (5)
At time                  125, value = 06 (6)
At time                  135, value = 07 (7)
At time                  145, value = 08 (8)
At time                  155, value = 09 (9)
At time                  165, value = 0a (10)
counter_testbench.v:10: $stop called at 168 (1s)

*/
module test;

  /* Make a reset that pulses twice. 
     # 17 means delay 17 cycles
     The second rising edge happens at 17+11+29=57

     Because this is an initial block, the delays
     are all relative to the start of time.

     The counter block resets on the positive-going
     edge of the resset signal.
  */
  reg reset = 0;

  initial begin
     # 17 reset = 1;
     # 11 reset = 0;
     # 29 reset = 1;
     # 11 reset = 0;
     # 100 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;

  // #5 puts a 5 cycle delay between each transition
  // of the register. This creates a cycle because it 
  // is in an always block.
  always begin 
     #5 clk <= !clk;
  end

  wire [7:0] value;
  counter c1 (value, clk, reset);

  initial
      // Notice that we only get output when something changes.
     $monitor("At time %t, clk: %0d, reset: %0d, value: %0d", 
       $time, clk, reset, value);

endmodule
