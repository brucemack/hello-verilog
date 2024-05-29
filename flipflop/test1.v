module test1;

    reg clk;
    reg rst;
    reg in;
    wire out;

    // Instantiate the flip-flop
    dflipflop f0(in, clk, rst, out);

    initial begin 

        clk = 0;
        rst = 1;
        in = 0;

        $display("0: [%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);

        #1;
        $display("1a: [%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);
        rst <= 0;
        // The reset change won't be seen here because it 
        // is delayed until the end of the timestep.
        $display("1b: [%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);

        // IMPORTANT: The negedge of the rst transition 
        // inside of the flipflop will be seen and processed 
        // at the VERY END of time step (i.e. before moving 
        // past the next delay).

        #1;
        $display("2a: [%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);
        rst <= 1;
        $display("2b: [%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);
        
        #1;
        in = 1;
        clk = 1;
        // We won't see the change in output here since the 
        // flip-flop uses a non-blocking assignment.
        $display("[%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);

        #1;
        clk = 0;
        $display("[%0t] clk: %0d, rst: %0d, in: %0d, out: %0d", 
          $time, clk, rst, in, out);

    end 

endmodule
