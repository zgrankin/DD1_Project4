//////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    deposit_fsm_zgrankin.v
// Author:      Zack Rankin
// Date:        4/19/2017
// Version:     1
// Description: FSM for a coin-operated vending machine to keep track
//				of amount of change deposited
//////////////////////////////////////////////////////////////////////////////////////////////

module deposit_fsm_zgrankin(clock, reset, enable, coin_in, dispenseReady, state);
	input  clock, reset, enable;
	input  [1:0] coin_in;
	output reg [5:0] dispenseReady;
	
	output reg [4:0] state;
	
	// states for each amount of money that could currently be in the vending machine
	parameter [4:0] s00 = 5'd0,  s05 = 5'd1,  s10 = 5'd2,
					s15 = 5'd3,  s20 = 5'd4,  s25 = 5'd5, 
					s30 = 5'd6,  s35 = 5'd7,  s40 = 5'd8, 
					s45 = 5'd9,  s50 = 5'd10, s55 = 5'd11, 
					s60 = 5'd12, s65 = 5'd13, s70 = 5'd14,
					s75 = 5'd15, s80 = 5'd16;
			  
	parameter [1:0] nocoin = 2'b00, nickel  = 2'b01, // types of coin inputs
					dime   = 2'b10, quarter = 2'b11;

	
	always @(posedge clock or negedge reset) begin
		if (!reset)
			state <= s00;
		
		else if (enable || (dispenseReady == 6'b100000)) begin
		case(state)	
				s00: begin // 0 cents
					if (coin_in == nocoin) 	 state <= s00;
					else if (coin_in == nickel)  state <= s05;
					else if (coin_in == dime) 	 state <= s10;
					else if (coin_in == quarter) state <= s25;
				end
				
				s05: begin // 5 cents
					if (coin_in == nocoin) 	 state <= s05;
					else if (coin_in == nickel)  state <= s10;
					else if (coin_in == dime) 	 state <= s15;
					else if (coin_in == quarter) state <= s30;
				end
				
				s10: begin // 10 cents
					if (coin_in == nocoin) 	 state <= s10;
					else if (coin_in == nickel)  state <= s15;
					else if (coin_in == dime) 	 state <= s20;
					else if (coin_in == quarter) state <= s35;
				end
				
				s15: begin // 15 cents
					if (coin_in == nocoin) 	 state <= s15;
					else if (coin_in == nickel)  state <= s20;
					else if (coin_in == dime)  	 state <= s25;
					else if (coin_in == quarter) state <= s40;
				end
				
				s20: begin // 20 cents
					if (coin_in == nocoin)		 state <= s20;
					else if (coin_in == nickel)  state <= s25;
					else if (coin_in == dime)  	 state <= s30;
					else if (coin_in == quarter) state <= s45;
				end
				
				s25: begin // 25 cents
					if (coin_in == nocoin) 	 state <= s25;
					else if (coin_in == nickel)  state <= s30;
					else if (coin_in == dime)  	 state <= s35;
					else if (coin_in == quarter) state <= s50;
				end
				
				s30: begin // 30 cents
					if (coin_in == nocoin) 	 state <= s30;
					else if (coin_in == nickel)  state <= s35;
					else if (coin_in == dime)  	 state <= s40;
					else if (coin_in == quarter) state <= s55;
				end
				
				s35: begin // 35 cents
					if (coin_in == nocoin) 	 state <= s35;
					else if (coin_in == nickel)  state <= s40;
					else if (coin_in == dime)  	 state <= s45;
					else if (coin_in == quarter) state <= s60;
				end	
				
				s40: begin // 40 cents
					if (coin_in == nocoin) 	 state <= s40;
					else if (coin_in == nickel)  state <= s45;
					else if (coin_in == dime)  	 state <= s50;
					else if (coin_in == quarter) state <= s65;
				end	
				
				s45: begin // 45 cents
					if (coin_in == nocoin) 	 state <= s45;
					else if (coin_in == nickel)  state <= s50;
					else if (coin_in == dime)  	 state <= s55;
					else if (coin_in == quarter) state <= s70;
				end	
				
				s50: begin // 50 cents
					if (coin_in == nocoin) 	 state <= s50;
					else if (coin_in == nickel)  state <= s55;
					else if (coin_in == dime) 	 state <= s60;
					else if (coin_in == quarter) state <= s75;
				end	
				
				s55: begin // 55 cents
					if (coin_in == nocoin) 	 state <= s55;
					else if (coin_in == nickel)  state <= s60;
					else if (coin_in == dime) 	 state <= s65;
					else if (coin_in == quarter) state <= s80;
				end	
				
				s60: begin // 60 cents
					state = s00;
				end	
				
				s65: begin // 65 cents
					state = s00;
				end	
				
				s70: begin // 70 cents
					state = s00;
				end	
				
				s75: begin // 75 cents
					state = s00;
				end	
				
				s80: begin // 80 cents
					state = s00;
				end	

				default: state = 5'bxxxxx;
			endcase
		end
	end

	always@(state) begin
		if 		(state == s60)	dispenseReady = 6'b000001;
		else if (state == s65)	dispenseReady = 6'b000010;
		else if (state == s70)	dispenseReady = 6'b000100;
		else if (state == s75)	dispenseReady = 6'b001000;
		else if (state == s80)	dispenseReady = 6'b010000;
		else 					dispenseReady = 6'b000000;
	end
		
endmodule