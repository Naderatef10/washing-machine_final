module timer_tb;

  reg  clk_tb;
  reg timer_pause_tb;
  reg state_time_tb ;
  reg double_time_tb;
  reg rst_n_tb;
  reg  [1:0]  clk_freq_tb;
  wire  timer_finish_tb;


timer t1(
.clk(clk_tb),
.timer_pause(timer_pause_tb),
.state_time(state_time_tb),
.double_time(double_time_tb),
.rst_n(rst_n_tb),
.clk_freq(clk_freq_tb),
.timer_finish(timer_finish_tb)
);

initial 
begin



rst_n_tb=0;
#50 rst_n_tb=1;
clk_freq_tb=2'b00;
state_time_tb = 1;
#50 state_time_tb=0;
timer_pause_tb = 0;
double_time_tb=0;


end

always 
#50000 clk_tb=~clk_tb;



endmodule