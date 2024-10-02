`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:20:43 08/27/2023 
// Design Name: 
// Module Name:    driveok_d 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/////////////////////////////////////////////////////////////////////////////////
module DriveOkDetector(
	input Clk50M,
	input [7:0] RData,
	input DVPulse,
	
	output reg DTog  );


reg [2:0] State;

initial begin

	State <= 0;
	DTog <= 0;
end

always @(posedge Clk50M) begin
case(State)
	0:begin
		if(DVPulse) begin
			if(RData == 8'd111) begin // detecting the letter o
				State <= 1;
			end
		end
	end
	1:begin
		if(DVPulse && (RData == 8'd107)) begin //detecting the letter k
			State <= State+1;
		end
	end
	2:begin
		if(DVPulse && (RData == 8'd13)) begin //enter
			State <= State+1;
		end
	end
	
	3:begin
		DTog <= (~DTog);
		State <= 0;
	end
	
	default:begin
		State <= 0;
	end
endcase
end

endmodule

