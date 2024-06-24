// Demonstration of an endless loop?
module rslatch();

    reg set0;
    reg rst0;
    reg m;
    reg q;

    // Dangerous: SELF TRIGGER LEADS TO ENDLESS LOOP
    always @(*) begin
        m <= !(set0 & q);
        q <= !(rst0 & m);
    end

    initial begin 

        $monitor("MON: [%0t] set0: %0d, rst0: %0d, q: %0d", $time, set0, rst0, q);
        $strobe("STR: [%0t] set0: %0d, rst0: %0d, q: %0d", $time, set0, rst0, q);

        // Initial state
        set0 = 1;
        rst0 = 1;
        // Bad state!!!
        m = 0;
        q = 0;

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

        #1;
        $stop;
    end

endmodule