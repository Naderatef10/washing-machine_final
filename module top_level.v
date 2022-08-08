module top_level(

input wire clk,
input wire rst_n,
input wire [1:0] clk_freq,
input wire coin_in,
input wire double_wash,
input wire timer_pause,
output wire wash_done

);


wire timer_finish, state_time,double_time;

FSM f1(
.rst_n(rst_n),
.clk_fsm(clk),
.coin_in(coin_in),
.double_wash (double_wash),
.timer_finish(timer_finish),
.state_time(timer_finish)
.double_time(double_time),
.wash_done(wash_done)
);

timer t2 (

.clk(clk),
.timer_pause(timer_pause),
.state_time(state_time),
.double_time(double_time),
.rst_n(rst_n),
.clk_freq(clk_freq),
.timer_finish(timer_finish)


);


endmodule