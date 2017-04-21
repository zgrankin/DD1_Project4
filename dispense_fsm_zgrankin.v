module dispense_fsm_zgrankin(clock, reset, nickelCount, dimeCount, subNickel, subDime, dispenseReady);
	
	input clock;
	input reset;
	input		[7:0] nickelCount, dimeCount;
	output reg 	[5:0] dispenseReady;
	output reg 	[7:0] subNickel, subDime;
	
	parameter [4:0]	s60 = 5'd12, s65 = 5'd13, s70 = 5'd14,
					s75 = 5'd15, s80 = 5'd16;
					
   	parameter [1:0] nocoin = 2'b00, nickel  = 2'b01, // types of coin inputs
					dime   = 2'b10, quarter = 2'b11;
					
	parameter [5:0] dispense =   6'b000001, dispense5  = 6'b000010, 
					dispense10 = 6'b000100, dispense15 = 6'b001000, 
					dispense20 = 6'b010000;
					
	
	always @(posedge clock or negedge reset) begin
		if(!reset)
			dispenseReady <= 6'b100000;
		else if (dispenseReady > 6'b000000 && dispenseReady != 6'b100000) begin
			case(dispenseReady)
				dispense: begin
					subNickel <= 8'd0;
					subDime <= 8'd0;
					dispenseReady <= 6'b100000;
				end
				
				dispense5: begin
					if (nickelCount >= 8'd1)	subNickel <= 8'd1;
					dispenseReady <= 6'b100000;
				end
				
				dispense10: begin
					if (dimeCount >= 8'd1)			subDime <= 8'd1;
					else if (nickelCount >= 8'd2) 	subNickel <= 8'd2;
					dispenseReady <= 6'b100000;
				end
				
				dispense15: begin 
					if (dimeCount >= 8'd1 && nickelCount >= 8'd1) begin
						subDime <= 8'd1;
						subNickel <= 8'd1;
					end
					else if (nickelCount >= 8'd3) begin
						subNickel <= 8'd3;
					end
					dispenseReady <= 6'b100000;
				end
				
				dispense20: begin
					if (dimeCount >= 8'd2) begin
						subDime <= 8'd2; 
					end
					else if (dimeCount >= 8'd1 && nickelCount >= 8'd2) begin
						subDime <= 8'd1;
						subNickel <= 8'd2;
					end
					else if (nickelCount >= 8'd4) begin
						subNickel <= 8'd4;
					end
					dispenseReady <= 6'b100000;
				end
			endcase
		end
	end
endmodule