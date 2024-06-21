// Here we show that state can be maintained in a circuit 
// without any explicit latch or <=

module bistable_2();

    reg a = 0, b = 0;
    // There is no problem with this logicl loop
    wire c = (c | a);

    initial begin 

        $monitor("MON: 0: [%0t], a: %0d, c: %0d", 
            $time, a, c);

        #1;
        a = 1;
        #1;
        a = 0;

        #20 $stop;

    end 

endmodule 
