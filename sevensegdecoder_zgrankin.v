// Filename:    sevensegdecoder_zgrankin.v
// Author:     Zack Rankin 
// Date:       3/26/2017 
// Version:    1
// Description: Continuous assignment model for seven segment decoder with a
//				4 bit input and 7 bit output
//       
//////////////

module sevensegdecoder_zgrankin(digit, hex_driver);
   input  [3:0] digit;
   output [6:0] hex_driver;
   
   
   // if input should light up specific segment set value to 0, if not set value to 1
   
   // check for all inputs that have '0' segment lit
   assign hex_driver[0] = ((digit == 4'd0) | (digit == 4'd2) | (digit == 4'd3)
   | (digit == 4'd5) | (digit == 4'd6) | (digit == 4'd7) | (digit == 4'd8)
   | (digit == 4'd9) | (digit == 4'd10) | (digit == 4'd12) | (digit == 4'd14)
   | (digit == 4'd15)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '1' segment lit
   assign hex_driver[1] = ((digit == 4'd0) | (digit == 4'd1) | (digit == 4'd2)
   | (digit == 4'd3) | (digit == 4'd4) | (digit == 4'd7) | (digit == 4'd8)
   | (digit == 4'd9) | (digit == 4'd10) | (digit == 4'd13)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '2' segment lit
   assign hex_driver[2] = ((digit == 4'd0) | (digit == 4'd1) | (digit == 4'd3)
   | (digit == 4'd4) | (digit == 4'd5) | (digit == 4'd6) | (digit == 4'd7)
   | (digit == 4'd8) | (digit == 4'd9) | (digit == 4'd10) | (digit == 4'd11)
   | (digit == 4'd13)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '3' segment lit
   assign hex_driver[3] = ((digit == 4'd0) | (digit == 4'd2) | (digit == 4'd3)
   | (digit == 4'd5) | (digit == 4'd6) | (digit == 4'd8) | (digit == 4'd9)
   | (digit == 4'd11) | (digit == 4'd12) | (digit == 4'd13) | (digit == 4'd14)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '4' segment lit
   assign hex_driver[4] = ((digit == 4'd0) | (digit == 4'd2) | (digit == 4'd6)
   | (digit == 4'd8) | (digit == 4'd10) | (digit == 4'd11) | (digit == 4'd12)
   | (digit == 4'd13) | (digit == 4'd14) | (digit == 4'd15)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '5' segment lit
   assign hex_driver[5] = ((digit == 4'd0) | (digit == 4'd4) | (digit == 4'd5)
   | (digit == 4'd6) | (digit == 4'd8) | (digit == 4'd9) | (digit == 4'd10)
   | (digit == 4'd11) | (digit == 4'd12) | (digit == 4'd14) | (digit == 4'd15)) ? 1'b0 : 1'b1;
   
   // check for all inputs that have '6' segment lit
   assign hex_driver[6] = ((digit == 4'd2) | (digit == 4'd3) | (digit == 4'd4)
   | (digit == 4'd5) | (digit == 4'd6) | (digit == 4'd8) | (digit == 4'd9)
   | (digit == 4'd10) | (digit == 4'd11) | (digit == 4'd13) | (digit == 4'd14)
   | (digit == 4'd15)) ? 1'b0 : 1'b1;
   
   // END INSERT

endmodule
