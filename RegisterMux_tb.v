`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:06:39 01/10/2024
// Design Name:   RegisterMux
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_final/cpu4bit/RegisterMux_tb.v
// Project Name:  cpu4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterMux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "RegisterMux.v"
module RegisterMux_tb;

	// Inputs
	reg clock;
	reg [3:0] ReadData2;
	reg [3:0] Immediate;
	reg ALUSrc;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	RegisterMux uut (
		.clock(clock), 
		.ReadData2(ReadData2), 
		.Immediate(Immediate), 
		.ALUSrc(ALUSrc), 
		.out(out)
	);
	always begin
	#50 clock = !clock;
	end
	
	initial begin
		// Initialize Inputs
		clock = 1;
		ReadData2 = 2;
		Immediate = 5;
		ALUSrc = 0;

		// Wait 100 ns for global reset to finish
		#100;
      ReadData2 = 2;
		Immediate = 5;
		ALUSrc = 1;
		#100;
      ReadData2 = 3;
		Immediate = 6;
		ALUSrc = 0;
		#100;
      ReadData2 = 3;
		Immediate = 6;
		ALUSrc = 1;
		#100;
      ReadData2 = 0;
		Immediate = 0;
		ALUSrc = 0;

	end
      
endmodule

