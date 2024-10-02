`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:05 08/27/2023 
// Design Name: 
// Module Name:    top_module 
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
////////////////////////////////////////////////////////////////////////////////
module Copley_RS232_Rec(Clk50M, 
                        RX,   
                        DriveOk); 

    input Clk50M;
    input RX;
   output DriveOk;
   
   wire det_toggler;
   wire [7:0] SerData;
   wire SerDV;
   wire XLXN_140;
   wire [15:0] XLXN_141;
   
   assign XLXN_141 = 16'h01b2;
   
   InputFilter  XLXI_430 (.Clk(Clk50M), 
                         .DIn(RX), 
                         .DOut(XLXN_140));
   DriveOkDetector  XLXI_437 (.Clk50M(Clk50M), 
                             .DVPulse(SerDV), 
                             .RData(SerData[7:0]),  
                             .DTog(det_toggler) );   
   SerialRecvEngine  XLXI_443 (.Clk(Clk50M), 
                              .limit(XLXN_141[15:0]), 
                              .rx(XLXN_140), 
                              .data(SerData[7:0]),    
                              .data_valid(SerDV));   
   Trigdetector  XLXI_445  (.Clk(Clk50M),
                            .det_toggle(det_toggler),
							.led(DriveOk) );
	
endmodule
