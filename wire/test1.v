/*
*/
module test1;

    reg a;
    // Hard-wired to 1
    wire b = 1;
    // Boolean logic - takes a time step to propagate.
    wire c = a & b;
    // Direct assignment - propagates immediately.
    wire d = a;

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
        // but c doesn't change until a step goes by - time
        // is required to propagate the Boolean function.
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
        #1;
        // Now the propagation has finished and we can see
        // the result of the Boolean expression for c.
        $display("[%0t] a: %0d, b: %0d, c: %0d, d: %0d", 
            $time, a, b, c, d);
    end 

endmodule
