////////////////////////////////////////////////////////////////////////////////
// Filename:    counter4bit.v
// Author:      Zack Rankin
// Date:        4/21/2017
// Version:     4
// Description: This module is a behavioral description of a simple four-bit
//              counter with enable and asynchronous clear.
//
// 		This module has three inputs and one output:
//              - enable: An active-high signal that advances the count when
//                        asserted. (input)
//              - reset:  An asynchronous active-high clear. (input)
//              - clk:    The system clock. (input)
//              - cout:	  The 4-bit counter value. (output)
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module counter4bit (clock, reset, enable, coin_in, subNickel, subDime, dispenseReady, nickelCount, dimeCount, quarterCount);
   input        enable;		// Active-high counter enable.
   input        reset;		// Asynchronous active-low reset
   input        clock;		// System clock
   input [7:0]	subNickel, subDime;
   input [1:0]	coin_in;
   input [5:0]	dispenseReady;
   output reg [7:0] nickelCount, dimeCount, quarterCount; // 4-bit counter output
   
   	parameter [1:0] nocoin = 2'b00, nickel  = 2'b01, // types of coin inputs
					dime   = 2'b10, quarter = 2'b11;
					
	parameter [5:0] dispense =   6'b000001, dispense5  = 6'b000010, 
					dispense10 = 6'b000100, dispense15 = 6'b001000, 
					dispense20 = 6'b010000;

// Build behavioral 8-bit up-counter with asynchronous clear
   always @(posedge clock or negedge reset) begin
		if(!reset) begin 
			nickelCount 	<= 8'b0;
			dimeCount		<= 8'b0;
			quarterCount	<= 8'b0;
		end
		else if (enable) begin
			if (coin_in == nickel)
				nickelCount <= nickelCount + 8'd1;
			else if (coin_in == dime)
				dimeCount <= dimeCount + 8'd1;
			else if (coin_in == quarter)
				quarterCount <= quarterCount + 8'd1;
		end
		else begin
			nickelCount <= nickelCount - subNickel;
			dimeCount <= dimeCount - subDime;
		end
	end

endmodule
