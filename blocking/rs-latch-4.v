// Demonstration of an endless loop?
module rslatch();

    reg system_clock;
    reg set0;
    reg rst0;
    reg q;

    always begin
        #1; system_clock <= ~system_clock;
    end

    always @(posedge(system_clock)) begin
        if (!set0 & rst0)
            q <= 1;
        else if (!rst0 & set0)
            q <= 0;
        else if (!rst0 & !set0)
            q <= 1'bx;
    end


    initial begin 

        $monitor("MON: [%0t] sc: %0d, set0: %0d, rst0: %0d, q: %0d", $time, system_clock, set0, rst0, q);

        // Initial state
        system_clock = 0;
        set0 = 1;
        rst0 = 1;

        // Demonstrate a set
        #4;
        set0 = 0;
        #2; 
        set0 = 1;

        // Demonstrate a reset
        #4;
        rst0 = 0;
        #2; 
        rst0 = 1;

        #10;
        $stop;
    end

endmodule