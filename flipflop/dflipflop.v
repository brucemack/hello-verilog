module dflipflop(d, clk, async_reset, q);
  
  input d, clk, async_reset;
  output reg q;

  always @(posedge clk or negedge async_reset) 
  begin
    $display("Transition seen at %0t", $time);
    if (async_reset == 0)
      q <= 0;
    else 
      q <= d; 
  end 

endmodule 