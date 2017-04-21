module determineLEDs_zgrankin(clock, reset, nickelCount, dimeCount, quarterCount, LED);

	input clock;
	input reset;
	input [7:0] nickelCount, dimeCount, quarterCount;
	output reg [7:0] LED;
	
	always @(posedge clock or negedge reset) begin
		if (!reset)
			LED = 8'b00001000;
		else begin
			if (nickelCount == 7'd0  && dimeCount == 7'd0)
				LED = LED | 8'b00001000;
			else
				LED = LED & 8'b11110111;
			
		end
	
	end
	
endmodule