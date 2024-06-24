module test3;

    reg a;
    reg b;
    reg c;

    initial begin 
        a = 1;
        c = 1;
        $monitor("MON [%0t] a: %0d, b: %0d, c: %0d", $time, a, b, c);
    end

    always @(*) begin 
        // Causes an infinite loop
        b = !a | c;
    end

endmodule
