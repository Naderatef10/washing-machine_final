module FSM (
    input  wire   rst_n, clk_fsm, coin_in, double_wash, timer_finish,
    output wire    state_time,double_time,
    output reg    wash_done
);
reg [2:0] present_state, next_state;
reg count, state_time_reg, double_time_reg;
localparam A=3'b000, B=3'b001, C=3'b010,
           D=3'b011, E=3'b100;
assign state_time = state_time_reg;
assign double_time = double_time_reg;        
// define next state and output logic            
always@(*)
begin
    case(present_state)
    A:
        begin
            if(coin_in)
                begin
                next_state = B;
                state_time_reg = 1'b1;
                double_time_reg = 1'b0;
                wash_done = 1'b0;
                end
            else
            begin
                next_state = A; 
                state_time_reg = 1'b0;
                double_time_reg = 1'b0;
                wash_done = 1'b0; 
            end  
        end
    B:
        begin
            if(timer_finish)
              begin
                 next_state = C;
                  state_time_reg = 1'b1;
                  double_time_reg = 1'b0;
                  wash_done = 1'b0;
               end
             else
              begin
                next_state = B; 
                 state_time_reg = 1'b0;
                 double_time_reg = 1'b0;
                 wash_done = 1'b0;
                  end
         end 
    C:
        begin
            if(timer_finish)
             begin
                    next_state = D;
                    state_time_reg = 1'b1;
                    double_time_reg = 1'b0;
                    wash_done = 1'b0;
            end
            else
             begin
                    next_state = C; 
                    state_time_reg = 1'b0;
                    double_time_reg = 1'b0;
                    wash_done = 1'b0;
             end

        end 
    D:
        begin
            if(timer_finish == 0)
             begin
                next_state = D;
                state_time_reg = 1'b0;
                double_time_reg = 1'b0;
                wash_done = 1'b0;
                 end
            else if(double_wash && count == 0)
             begin
                next_state = C;
                state_time_reg = 1'b1;
                double_time_reg = 1'b1;
                wash_done = 1'b0;
                count = 1;
                  end
            else
             begin
                next_state = E;
                state_time_reg = 1'b1;
                double_time_reg = 1'b0;
                wash_done = 1'b0;
                 end
        end 
    E:
        begin
            if(timer_finish)
             begin
                next_state = A;
                state_time_reg = 1'b0;
                double_time_reg = 1'b0;
                wash_done = 1'b1;
                  end
            else
             begin
                next_state = E;
                state_time_reg = 1'b0;
                double_time_reg = 1'b0;
                wash_done = 1'b0;
                 end
        end 
    default:next_state = 3'bxxx;
endcase
end
//state transition
always@(negedge rst_n , posedge clk_fsm)
begin
    if(!rst_n)
        begin
        present_state<=A;
        state_time_reg = 1'b0;
        double_time_reg = 1'b0;
        wash_done = 1'b0;
        count = 0;
        end
    else
    begin
        present_state<=next_state;
    end
end
endmodule