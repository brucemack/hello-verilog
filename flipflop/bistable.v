module bistable();

    reg ac_set_left_0, gate_left_0, ac_set_right_0, gate_right_0;
    reg ac_set_left_1, gate_left_1, ac_set_right_1, gate_right_1;
    reg reset_left, reset_right;
    reg state;
    wire b, p;
    assign b = state;
    assign p = !state;
    
    always @(posedge ac_set_left_0) begin
        if (gate_left_0 == 1 & state == 1)
            state <= 0;
    end
    always @(posedge ac_set_right_0) begin
        if (gate_right_0 == 1 & state == 0)
            state <= 1;
    end

    always @(posedge reset_left) begin
        state <= 1;
    end
    always @(negedge reset_left) begin
        state <= 0;
    end
    always @(posedge reset_right) begin
        state <= 0;
    end
    always @(negedge reset_right) begin
        state <= 1;
    end

    initial begin 

        //$monitor("MON: 0: [%0t] b: %0d", 
        //    $time, b);

        state <= 1;
        reset_left = 1'bz;
        reset_right = 1'bz;

        #1
        // Won't do anything, gate isn't opened
        ac_set_left_0 = 1;
        ac_set_left_0 = 0;
        $display("Step 1: 0: [%0t] b: %0d p: %0d", $time, b, p);
        #1
        // Won't do anything, need rising edge of AC set
        gate_left_0 = 1;
        gate_left_0 = 0;
        $display("Step 2: 0: [%0t] b: %0d p: %0d", $time, b, p);
        #1
        // Open gate
        gate_left_0 = 1;
        // Generate a left pulse
        ac_set_left_0 = 1;
        ac_set_left_0 = 0;
        #1
        // Now we'll see the change
        $display("Step 3: 0: [%0t] b: %0d p: %0d", $time, b, p);
        #1
        // Generate a right pulse
        ac_set_right_0 = 1;
        ac_set_right_0 = 0;
        #1
        // No change
        $display("Step 4: 0: [%0t] b: %0d p: %0d", $time, b, p);
        // Open gate
        gate_right_0 = 1;
        // Generate a right pulse
        ac_set_right_0 = 1;
        ac_set_right_0 = 0;
        #1
        // Change
        $display("Step 5: 0: [%0t] b: %0d p: %0d", $time, b, p);
        #1
        // Test reset
        reset_right = 0;
        reset_right = 1'bz;
        #1
        // Change
        $display("Step 6: 0: [%0t] b: %0d p: %0d", $time, b, p);

        #20 $stop;
    end 

endmodule;

