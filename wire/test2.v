// This test cases shows a lot about the semantics of Verilog,
// and what is/isn't allowed.
module test2;

    // Please note that the initial value of this variable will be "x"
    reg a;
    // NOT ALLOWED! Can't assign to valuables outside of a procedure block
    //a = 1;
    // NOT ALLOWED! Variables can't be on the LHS of a continuous assignment
    //assign a = 1;  

    wire b = 0;
    wire c = 0;
    // Will change whenever an input changes
    wire d;
    // NOT ALLOWED! Must appear on the wire line.
    // d = a | b;
    // We can assign a value to a previously-defined net using assign.
    // When a conflict arrises (i.e. multiple assignments to d) the 
    // net takes on an "x" value.
    assign d = a | b;
    assign d = 1;

    // A function acts like a pure procedure block when it is called - i.e.
    // performs a sequence of steps.  There are no nets defined or
    // assigned in a function.
    function f1(input x, input y);
        // We are allowed to create variables in the function declaration
        reg q;
        begin
            // NOT ALLOWED! Can't have variables in unnamed blocks 
            //reg b;

            // NOTICE! Here we make a reference to net "d" which was defined
            // OUTSIDE of the function.
            f1 = x | q | d;

            // OK to assign to variables.  This is acting like a procedure 
            // block.
            q = 0;

            // Another way to reference the outside net.
            q = test2.d;
        end
    endfunction

    // Notice that this net has "wire and" behavior - i.e. e will be 
    // 1 when both RHS values are 1.
    //
    // Notice that one of the assignments to the net can happen in the 
    // declaration. 
    wand e = a | b;
    // Notice that we are allowed to use functions in the assignment
    assign e = f1(1, 0);

    // NOT ALLOWED! A variable can only be initialized using a constant
    //reg h = b;

    reg h = 1;
    // NOT ALLOWED! A variable can only be initialized using a constant.
    //reg i = h;

    // Can instantiate a module here
    mod1 m();

    initial begin 

        // Notice the use of hierarchical naming to probe into the nets
        // of module m.
        $monitor("[%0t] a: %0d, b: %0d, c: %0d, d: %0d, e: %0d. %m.b: %0d", 
            $time, a, b, c, d, e, m.b);

        // NOT ALLOWED! Nets are not allowed in procedure blocks
        //wire e;
        // NOT ALLOWED! Nets can't be re-assigned inside of procedure blocks
        //b = 0;
        // NOT ALLOWED! Nets can't be re-assigned inside of procedure blocks
        //assign b = 0;

        // NOT ALLOWED! Can't instantiate a module in a procedure block
        //mod1 n();

        #1;
        // Here we are assigign a value to a variable defined at the module level
        a = 1;            
        #5;
    end 

    always begin
        // NOT ALLOWED! Variables can't be created in unnamed procedure blocks
        //reg h;
        // NOT ALLOWED! Nets can't be declared in procedure blocks
        //wire e;
        // NOT ALLOWED! Nets can't be re-assigned inside of procedure blocks
        //assign b = 0;
        #1;
        $finish;
    end

endmodule
