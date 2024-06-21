// Demonstration of high-z
module test2;

    reg in_0;
    reg in_1;
    wire dot_0;
    assign dot_0 = (in_0 == 0 || in_1 == 0) ? 0 : 1'bz;
    assign dot_1 = (in_0 === 0 || in_1 === 0) ? 0 : 1'bz;

    initial begin 

        $monitor("MON: 0: [%0t] in0: %0d in1: %0d dot_0: %0d dot_1: %0d", 
            $time, in_0, in_1, dot_0, dot_1);

        // Here both inputs are floating.  Notice how dot_0 is indeterminant since
        // the == 0 evaluation can't work.
        //
        // But also notice how the === 0 works for the dot_1

        in_0 = 1'bz;
        in_1 = 1'bz;

        #1;
        // Here the output is known
        in_1 = 0;

        #1;
        // Here the output is known
        in_1 = 1;

        #20 $stop;
    end 

endmodule
