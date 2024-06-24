// This is an example of a meta-stable RS latch.
// 
module rslatch();

    reg set0;
    reg rst0;

    wire m;
    wire q;
    // Very standard RS latch with NAND gates, incorporating
    // a 2ns propagation delay for each gate. This creates a 
    // window where a "bad" reset can put the gate into
    // a meta-stable state.
    assign #2 m = !(set0 & q);
    assign #2 q = !(rst0 & m);

    initial begin 

        $monitor("MON: [%0t] set0: %0d, rst0: %0d, q: %0d", $time, set0, rst0, q);

        // Initial state
        set0 = 1;
        rst0 = 1;

        // A too-short set.  Notice that q is still in an undefined state after this.
        #9;
        set0 = 0;
        #1;
        set0 = 1;

        // A too-short reset.  Notice that q is still in an undefined state after this.
        #9;
        rst0 = 0;
        #1;
        rst0 = 1;

        // Here we demonstrate a long enough set
        #7;
        set0 = 0;
        #3;
        set0 = 1;

        // A long-enough reset
        #7;
        rst0 = 0;
        #3;
        rst0 = 1;

        #8;
        // Here we demonstrate what can happen with a set that is 
        // exactly the length of the gate propagation delay. This 
        // puts the logic into a state of oscilation
        set0 = 0;
        #2;
        set0 = 1;

        #100;
        $stop;
    end

endmodule