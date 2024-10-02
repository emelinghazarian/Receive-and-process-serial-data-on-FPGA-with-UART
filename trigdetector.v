module Trigdetector(
	input Clk,
	input det_toggle,
	
	output led
);

reg pre_dtog;
reg led_state;
reg [7:0] count ;
	
initial begin	
	
	    count <= 0;
        led_state <= 0;
	
	end 
	
always @(posedge Clk) begin	

      if (pre_dtog==det_toggle) begin
        count <= count +1;
      
      end else begin
	  pre_dtog <= det_toggle;
      count <= 0;	  
		        
      // Check if the counter has reached the threshold_value = 50

    end
      if (count >= 50 ) begin
        led_state <= 0; // Turn the LED off
      end else begin
        led_state <= 1; // Turn the LED on
      end 
 end

  assign led = led_state;


endmodule
