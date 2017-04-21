////////////////////////////////////////////////////////////////////////////////
// Filename: project4.v
// Author:   Zack Rankin
// Date:     18 April 2017
// Revision: 1
//
// Description:
// This is the top level module for ECE 3544 Project 4.
// Do not modify the module declarations or ports in this file.
// When synthesizing to the DE1-SoC, this file should be used with the provided
// Quartus project so that the FPGA pin assignments are made correctly.
//
// YOU MUST MAKE THE PIN ASSIGNMENTS FOR THE INPUTS AND OUTPUTS OF THIS MODULE.
// FOLLOW THE INSTRUCTIONS THAT YOU USED IN PROJECT 3.
// CONSULT THE MANUAL FOR INFORMATION ON THE PIN LOCATIONS.
//
// Modified for use with the DE1-SoC
	
module project4(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);
	
//==============================================================================
// PORT declarations: Do NOT modify these declarations.
//==============================================================================

// You must use this clock for the clock of all of your sequential hardware.

	input        CLOCK_50;										// This is the system clock.
	input  [1:0] KEY;												// KEY[1] should be used to enter operation codes and operands.
																		// KEY[0] should be used as reset, active low.
																		// The KEY pushbuttons are 1 when not pressed and 0 when pressed.
	input  [2:0] SW;												// SW[2] controls the mode.
																		// SW[1:0] represents a coin input.
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;	// The hex display outputs drive the seven segment displays.
	output [7:0] LED;												// The LED output drives the LEDs.

// You should add your reg/wire/parameter declarations here.
	wire [7:0] nickelCount, dimeCount, quarterCount;
	wire [7:0] subNickel, subDime;
	wire [4:0] depositState;
	wire [4:0] dispenseState;
	wire [5:0] dispenseReady;
	wire coin_out;
	wire enable;
	
//==============================================================================
// Module instantiantions: You should add your module instantions here.
//==============================================================================
	buttonpressed U1(.clock(CLOCK_50), .reset(KEY[0]), .button_in(KEY[1]), .pulse_out(enable));
	
	counter4bit coinCount(.clock(CLOCK_50), .reset(KEY[0]), .enable(enable), .coin_in(SW[1:0]), .subNickel(subNickel), .subDime(subDime), 
						  .nickelCount(nickelCount), .dimeCount(dimeCount), .quarterCount(quarterCount));
	
	deposit_fsm_zgrankin deposit(.clock(CLOCK_50), .reset(KEY[0]), .enable(enable), .coin_in(SW[1:0]), 
								 .dispenseReady(dispenseReady), .state(depositState));
		
	determineLEDs_zgrankin lights(.clock(CLOCK_50), .reset(KEY[0]), .nickelCount(nickelCount), .dimeCount(dimeCount), .quarterCount(quarterCount), .LED(LED));
	
	dispense_fsm_zgrankin dispense(.clock(CLOCK_50), .reset(KEY[0]), .nickelCount(nickelCount), .dimeCount(dimeCount), .subNickel(subNickel), .subDime(subDime), .dispenseReady(dispenseReady));
		
	sevensegdecoder_zgrankin quarterMSB(.digit(quarterCount[7:4]), .hex_driver(HEX5));
	sevensegdecoder_zgrankin quarterLSB(.digit(quarterCount[3:0]), .hex_driver(HEX4));
	sevensegdecoder_zgrankin dimeMSB(.digit(dimeCount[7:4]), .hex_driver(HEX3));
	sevensegdecoder_zgrankin dimeLSB(.digit(dimeCount[3:0]), .hex_driver(HEX2));
	sevensegdecoder_zgrankin nickelMSB(.digit(nickelCount[7:4]), .hex_driver(HEX1));
	sevensegdecoder_zgrankin nickelLSB(.digit(nickelCount[3:0]), .hex_driver(HEX0));
	
	
	
// 

					  
endmodule
