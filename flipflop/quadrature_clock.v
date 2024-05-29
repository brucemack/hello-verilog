module quadrature_clock(clk, rst, out_i, out_q);

    input clk, rst;
    wire out_0;
    wire out_1;
    // Negate the output
    wire in_0 = !out_0;
    // Negate the output
    wire in_1 = !out_1;
    // In-phase and quadrature outputs
    output out_i;
    output out_q;
    assign out_i = !out_1 & !out_0;
    assign out_q = !out_1 & out_0;

    // Instantiate the level 0 flip-flop
    dflipflop f0(in_0, clk, rst, out_0);
    // Level 1 gets clocked by level 0
    dflipflop f1(in_1, out_0, rst, out_1);

endmodule
