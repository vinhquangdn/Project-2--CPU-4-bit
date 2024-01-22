`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:50:55 01/10/2024
// Design Name:   PCMux
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_final/cpu4bit/PCMux_tb.v
// Project Name:  cpu4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCMux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "PCMux.v"
module PCMux_tb;

	// Inputs
	reg clock;
	reg [3:0] nextPC;
	reg [3:0] branchPC;
	reg Jump;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	PCMux uut (
		.clock(clock), 
		.nextPC(nextPC), 
		.branchPC(branchPC), 
		.Jump(Jump), 
		.nextnextPC(out)
	);

	always begin
	#50 clock = !clock;
	end
	
	initial begin
		// Initialize Inputs
		clock = 1;
		nextPC = 2;
		branchPC = 5;
		Jump = 0;

		// Wait 100 ns for global reset to finish
		#100;
      nextPC = 2;
		branchPC = 5;
		Jump = 1;
		#100;
      nextPC = 3;
		branchPC = 6;
		Jump = 0;
		#100;
      nextPC = 3;
		branchPC = 6;
		Jump = 1;
		#100;
      nextPC = 0;
		branchPC = 0;
		Jump = 0;
		
		
	end
      
endmodule

