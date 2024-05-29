// Divide by 4 example
// Shows I and Q clock outputs
module test2;

    reg clk = 0;
    reg rst;

    wire out_0;
    wire out_1;
    // Negate the output
    wire in_0 = !out_0;
    // Negate the output
    wire in_1 = !out_1;
    
    // In-phase and quadrature outputs
    wire out_i = !out_1 & !out_0;
    wire out_q = !out_1 & out_0;

    // Instantiate the level 0 flip-flop
    dflipflop f0(in_0, clk, rst, out_0);
    // Level 1 gets clocked by level 0
    dflipflop f1(in_1, out_0, rst, out_1);

    initial begin 

        //$monitor("MON: 0: [%0t] clk: %0d, rst: %0d, in0: %0d, out0: %0d, out1: %0d", 
        //  $time, clk, rst, in_0, out_0, out_1);

        $monitor("MON: 0: [%0t] out0: %0d, i: %0d, q: %0d", 
            $time, out_0, out_i, out_q);

        rst = 1;
        #1;
        rst = 0;
        #1;
        rst = 1;

        #20 $stop;

    end 

    // Constant clock
    always begin 
        #1 clk = 1; clk = 0;
    end

endmodule
