`default_nettype none

module tb;
  reg clk,a,b,runstop,reset;
  wire led1,led2,led3,led4,led5;
  demo dut(led1,led2,led3,led4,led5,clk,a,b,runstop,reset);
 
   
initial 
begin
    
  $dumpfile("dump.vcd");
  $dumpvars(0,dut);

  clk = 1'b0;
  a=1'b0;
  b=1'b0;
  runstop = 0;
  reset =1'b1; //hold your horses!
  
  #10

  reset = 1'b0; // get set go!
  
  #2
  
  a=1'b1;
  
  #4
  
  b=1'b1;
  
  #4
  
  a=1'b0;
  
  #4
  
  b=1'b0;
  
  #4
  $finish;
    
end

//clock generator

always
begin
    #1
    clk <=~ clk;
end



endmodule