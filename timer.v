module timer (
input  wire             clk, timer_pause, state_time, double_time, rst_n,
input  wire      [1:0]  clk_freq,
output wire             timer_finish
);
reg  timer_finish_reg ;
reg  [31:0] clk_freq_reg;
reg  [31:0] counter;
assign timer_finish = timer_finish_reg;
reg [2:0] present_state, next_state;
reg counter_finish;
reg temp_counter;
reg count ;


always@(clk_freq)
begin
    case(clk_freq)
    2'b00:begin
        clk_freq_reg = 1000000;
          end
    2'b01:begin
        clk_freq_reg = 2000000;
          end
    2'b10:begin
        clk_freq_reg = 4000000;
          end
    2'b11:begin
        clk_freq_reg = 8000000;
          end
      
   
          
    endcase
end


// determining next state 
localparam A=3'b000, B=3'b001, C=3'b010,
           D=3'b011, E=3'b100;
/*********************************************************************************************************************************************************/

    always@(*)
    begin 

    case (present_state)

    A: if(state_time == 1)
      
      begin 
            next_state = B;

      end 
    else

    begin 
           next_state = A;

    end  

    B: if(state_time == 1 || counter_finish)
      
      begin 
            next_state = C;

      end 
    else

    begin 
             next_state = B;

    end  



    C:if(state_time == 1 || counter_finish)
      
      begin 
            next_state = D;

      end 
    else

    begin 

            next_state = C;
    end  



    D:if(state_time == 1 || counter_finish)
      
      begin 

           if(double_time==1 && count == 0)

           begin
          next_state = C ;
          count = count + 1;
           end 

           else 

           begin
           next_state = E;

           end 

      end 
    else

    begin 

            next_state = D;
    end  




    E:if(state_time == 1 || counter_finish)
      
      begin 
            next_state = A;

      end 
    else

    begin 
           next_state = E;


    end  

    endcase 



    end 

/******************************************************************************************************************************/
// counter_logic 


always @ (posedge clk , posedge timer_pause )

begin 


if(timer_pause)
begin 

counter <= counter ;

end 

else if (state_time == 0 && ! timer_pause )

begin 

counter <= counter + 1; 

end 

else 

begin 


counter <= 0; 


end 


end 

/******************************************************************************************************************************/

// transition register logic 

always @ (posedge clk, negedge rst_n )


begin 


if(!rst_n)

begin 

counter <=0 ; 
present_state <= A;
timer_finish_reg <=0;
counter_finish <=0;
timer_finish_reg <=0;
count <=0;

end


else 

begin 

present_state <= next_state;


end 


end 


/**************************************************************************************** ***********************************************************************************/


// output logic 
always @(posedge clk)


begin


case (present_state)


A:  begin 
              counter_finish <= 0;
              timer_finish_reg  <= 0 ;
              end 





B: if(counter == 2*60*clk_freq_reg)

   begin 
    
    counter_finish <= 1;
    timer_finish_reg <=1;
    counter <= 0;

   end 

   else 

   begin


    counter_finish <=0;
    timer_finish_reg <=0 ;

   end 


C:

if(counter == 5*60*clk_freq_reg)

   begin 
    
    counter_finish  <=1;
    timer_finish_reg  <=1;
     counter  <=0;


   end 

   else 

   begin

    counter_finish  <=0;
    timer_finish_reg <=0 ;

   end 



D:

if(counter == 2*60*clk_freq_reg)

   begin 
    
    counter_finish <= 1;
    timer_finish_reg <=1;
     counter <= 0;


   end 

   else 

   begin

    counter_finish <=0;
    timer_finish_reg <=0 ;

   end 



E:


if(counter == 60*clk_freq_reg)

   begin 
    
    counter_finish <=1;

    timer_finish_reg <=1;
     counter  <=0;


   end 

   else 

   begin

    counter_finish <=0;
    timer_finish_reg <=0 ;

   end 




default: 
              begin 
              counter_finish <=0;
              timer_finish_reg <=0 ;
               counter <= 0;
              end 



endcase 

end

endmodule