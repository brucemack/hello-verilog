// Demonstration of high-z
module test1;

    reg out_0;
    reg out_1;
    wire out_2;
    assign out_2 = out_0 & out_1;

    initial begin 

        $monitor("MON: 0: [%0t] out0: %0d out1: %0d out2: %0d", 
            $time, out_0, out_1, out_2);

        // Here the output is indeterminant
        out_0 = 1'bz;
        out_1 = 1;
        #1;
        // Here the output is known
        out_1 = 0;

        #20 $stop;
    end 

endmodule

