/*
A test that highlights a few things:

1. Blocking assignments are sequenced WITHIN A BLOCK.
2. The two initial blocks proceed in parallel.  Meaning: 
   the long delay in the first block doesn't slow down
   the second block.
3. 
*/
module test1;

    reg a, b, c;
    wire d = !a;

    initial begin 
        // These two settings will be sequenced in program
        // order WITHIN THE SAME TIME STEP.  The first 
        // assignment blocked the second.
        a = 0;
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", $time, a, b, c, d);
        a = 1;
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", $time, a, b, c, d);
        a = 0;
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", $time, a, b, c, d);
        #5
        b = 1;
        $display("[%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
    end 

    initial begin 
        // This is a parallel block, so the delay in the block
        // above is not delaying this assignment.
        c = 1;
        $display("[%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
    end 

endmodule
