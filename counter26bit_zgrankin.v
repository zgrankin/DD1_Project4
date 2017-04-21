////////////////////////////////////////////////////////////////////////////////
// Filename:    counter26bit.v
// Author:      Zack Rankin
// Date:        4/21/2017
// Version:     1
// Description: This module is a behavioral description of a simple 26-bit
//              counter with enable and asynchronous clear.
//
// 		This module has three inputs and one output:
//              - enable: An active-high signal that advances the count when
//                        asserted. (input)
//              - clear:  An asynchronous active-high clear. (input)
//              - clk:    The system clock. (input)
//              - cout:	  The 26-bit counter value. (output)
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module counter4bit (enable, reset, clk, count, second);
   input        enable;		// Active-high counter enable.
   input        reset;		// Asynchronous active-high clear
   input        clock;		// System clock
   output reg [25:0] count;		// 4-bit counter output

// Build behavioral 26-bit up-counter with asynchronous clear
   always @(posedge clk or posedge clear) begin
      if(clear)
         count <= 26'b0;
      else begin
         if(enable) begin
            if(count == 26'd49999999) begin
               count <= 26'b0;
			   second = 1'b1;
			end 
            else
               count <= count + 26'd1;
         end
      end
   end

endmodule
