/*
A test that highlights a few things:

1. Non-blocking assignments aren't visible until the 
   END of the time cycle. The evalations of the RHS
   of the assignments happen, but the assigment to 
   the LHS doesn't happen until the end of the cycle.
3. 
*/
module test1;

    reg a, b, c;

    initial begin 
        a <= 1;
        $display("BLOCK 1: [%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
        // NOTICE: The setting of a is not visible!
        #5
        b <= 1;
        // NOTICE: The setting of a is visible, but not b
        $display("BLOCK 1: [%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
        #1
        // NOTICE: Both a/b are visible now
        $display("BLOCK 1: [%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
    end 

    initial begin 
        c <= 1;
        // NOTICE: The setting of a/c is not visible yet
        $display("BLOCK 2: [%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
    end 

    reg d, e;

    // This case highlights the semantics of the non-blocking
    // assignment for a RHS that is changing within a timestep.
    initial begin 
        d = 1;
        $display("BLOCK 3.1: [%0t] d: %0d, e: %0d", $time, d, e);
        e <= d;
        // NOTICE: d is visible, but e is not (non-blocking)
        $display("BLOCK 3.2: [%0t] d: %0d, e: %0d", $time, d, e);
        d = 0;
        // NOTICE: d is visible, but e is not (non-blocking)
        $display("BLOCK 3.3: [%0t] d: %0d, e: %0d", $time, d, e);
        #1
        // NOTICE: e captured the value of d AT THE TIME OF THE 
        // ASSIGNMENT!  We did not capture the final value of d
        // in the timestep.  
        $display("BLOCK 3.4: [%0t] d: %0d, e: %0d", $time, d, e);
    end 

endmodule
