/*
*/
module test1;

    reg a;
    // Hard-wired to 1
    wire b = 1;
    wire c;
    // Direct assignment - likely propagates immediately.
    wire d = a;
    // Boolean logic - may or may not propagate immediately.
    assign c = a & b;

    initial begin 
        a = 0;
        // Notice that the c wire is in an unknown state
        // but d is in a known state.
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
        #1;
        // But in the next cycle the state of both is known
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
        // We change a here.
        a = 1;
        // Notice that d changes immediately (directly wired)
        // but c doesn't necessarily change. There
        // is some non-determinist here, likely related to 
        // the processing of the event queue.
        $display("DISPLAY 1: [%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
        // Here we use $strobe to wait until the end of 
        // the cycle. SO THE CHANGE TO C IS VISIBLE NOW!
        $strobe("STROBE 1: [%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);

        #1;
        // Now the propagation has finished and we can see
        // the result of the Boolean expression for c.
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
    end 

endmodule
