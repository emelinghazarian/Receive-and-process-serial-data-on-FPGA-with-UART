`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:07 08/27/2023 
// Design Name: 
// Module Name:    serial 
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
module SerialRecvEngine(
	input rx,
	input Clk,
	input [15:0] limit,

	output [7:0] data,
	output reg data_valid
);
 
wire [15:0] half_limit;
assign half_limit = (limit >> 1);

reg [9:0] buff; 
reg [3:0] state;
reg [15:0] count;
reg rx_pre_value;
reg half_limit_flag;

assign data[7:0] = buff[8:1];

initial begin

//limit=16'b0000000110110010;
//limit='h1B2;

	data_valid <= 0;
	buff <= 0;
	state <= 0;
	count <= 1;
	rx_pre_value <= 1;
	half_limit_flag <= 0;
end
 
always @(posedge Clk) begin
	if(state == 0) begin
		if(rx_pre_value != rx) begin
			if(rx_pre_value && !rx) begin
				data_valid <= 0;
				buff <= 0;
				state <= 1;
				count <= 1;
				half_limit_flag <= 0;
			end
			rx_pre_value <= rx;
		end
	end else if(state == 10) begin
		if(rx_pre_value != rx) begin
			buff[state-1] <= rx;
			state <= state+1;
			rx_pre_value <= rx;
		end else if(count == half_limit) begin
			state <= state+1;
			end else begin
			count <= count+1;
		end
	end else if(state == 11) begin
		state <= 0;
		if(buff[9]) begin
			data_valid <= 1;
		end
	end else begin
		if(rx_pre_value != rx) begin
			if(!half_limit_flag) begin
				buff[state-1] <= rx;
			end else begin
				buff[state] <= rx;
				state <= state+1;
			end
			count <= 1;
			half_limit_flag <= 0;
			rx_pre_value <= rx;
		end else if(count == limit) begin
			count <= 1;
			half_limit_flag <= 0;
			buff[state] <= rx;
			state <= state+1;
		end else begin
			count <= count+1;
			if(count == half_limit) begin
				half_limit_flag <= 1;
			end
		end
	end
end

endmodule
