`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:37 07/27/2023 
// Design Name: 
// Module Name:    in_filter 
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
//////////////////////////////////////////////////////////////////////////////////
module InputFilter(
	input Clk,
	input DIn,
	
	output reg DOut
);

parameter bit_num = 2;
parameter count_m = 7;


reg [7:0] count;


initial begin
	count <= 0;
end

always @(posedge Clk) begin
	if(DIn==1) begin
		if(count < count_m) begin
			count <= count+8'd1;
		end
	end else if(DIn==0)begin
		if(count > 8'd2) begin 
			count <= count-8'd1;
		end
	end
	DOut <= count[bit_num];
end

endmodule
