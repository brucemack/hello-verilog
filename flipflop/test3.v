// Divide by 4 example
// Shows I and Q clock outputs
module test2;

    reg clk = 0;
    reg rst = 0;
    
    // In-phase and quadrature outputs
    wire out_i;
    wire out_q;

    quadrature_clock qc1(clk, rst, out_i, out_q);

    initial begin 

        //$monitor("MON: 0: [%0t] clk: %0d, rst: %0d, in0: %0d, out0: %0d, out1: %0d", 
        //  $time, clk, rst, in_0, out_0, out_1);

        $monitor("MON: 0: [%0t], i: %0d, q: %0d", 
            $time, out_i, out_q);

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
