`default_nettype none

module demo(

  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  input clk, //clock
  input PMOD1,
  input PMOD2,
  input PMOD3,//runstop
  input PMOD4 //reset
);
  
  wire carry;
  
  wire in1, in2, runstop, reset;
  
  assign in1 = PMOD1;
  assign in2 = PMOD2;
  assign runstop = PMOD3;
  assign reset = PMOD4;

//Manage 12MHz clock
 reg [15:0] cnt1;
 reg [6:0] cnt2;
 reg [1:0] dec_cntr;
 reg  half_sec_pulse;

 reg carrylatch;

//same logic as adder

  wire [1:0] fullsum;
  assign fullsum = {1'b0, in1} + {1'b0, in2};
  
  assign LED1 = fullsum[0];
  assign LED2 = fullsum[1];
  assign carry= LED2;
  assign LED3= carrylatch;

//for carrylatch
  always @(posedge clk)
  begin 
    if (reset==1'b1) carrylatch<=1'b0;
    else begin 
        if (carry) carrylatch<=1'b1;
    end
  end

//For the counters
  always @(posedge clk)
  begin 
    if(reset=1'b1)
    begin
        cnt1<=16'b0;
        cnt2<=7'b0;
        dec_cntr=2'b0;
        half_sec_pulse=1'b0;
    end
    else if(runstop == 1'b0)
    begin
        cnt1 <= cnt1 + 16'h8000;
        if(cnt1==0)
        if(cnt2==2)
        begin
            cnt2 <= 0;
            half_sec_pulse <= 1;
        end 
        else
        cnt2 <=cnt2 +1;

        else 
        half_sec_pulse <=0;

        if(half_sec_pulse == 1)

        dec_cntr <= dec_cntr + 1;

    end
  end

  assign LED4 = (dec_cntr == 2);
  assign LED5 = dec_cntr[0];       



endmodule