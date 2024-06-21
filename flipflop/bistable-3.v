module bistable_3();

    reg k = 1, l = 1, q = 1, r = 1;

    wire n0 = k & l & n2;
    wire p = !n0;
    wire n2 = !(p & q & r);
    wire b = !n2;
    wire c = !p;

    initial begin 

        $monitor("MON: 0: [%0t], r: %0d, k: %0d, q: %0d, b: %0d, c: %0d", 
            $time, r, k, q, b, c);

        $display("Testing -R reset");
        r = 0;
        #1;
        r = 1;
        #1;

        $display("Testing -K");
        k = 0;
        #1;
        k = 1;
        #1;
        k = 0;
        #1;
        k = 1;
        #1;

        $display("Testing -Q");
        q = 0;
        #1;
        q = 1;
        #1;
        q = 0;
        #1;
        q = 1;
        #1;

        $display("Testing -R reset");
        r = 0;
        #1;
        r = 1;
        #1;




        #20 $stop;

    end 

endmodule 
