`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:13:41 01/10/2024
// Design Name:   InstructionMemMux
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_final/cpu4bit/InstructionMux_tb.v
// Project Name:  cpu4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMemMux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "InstructionMemMux.v"
module InstructionMux_tb;

	// Inputs
	reg clock;
	reg [1:0] addrRy;
	reg [1:0] addrRz;
	reg Reg2Loc;

	// Outputs
	wire [1:0] out;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemMux uut (
		.clock(clock), 
		.addrRy(addrRy), 
		.addrRz(addrRz), 
		.Reg2Loc(Reg2Loc), 
		.out(out)
	);

		always begin
	#50 clock = !clock;
	end
	
	initial begin
		// Initialize Inputs
		clock = 1;
		addrRy = 0;
		addrRz = 1;
		Reg2Loc = 0;

		// Wait 100 ns for global reset to finish
		#100;
      addrRy = 0;
		addrRz = 1;
		Reg2Loc = 1;
		#100;
      addrRy = 2;
		addrRz = 3;
		Reg2Loc = 0;
		#100;
      addrRy = 2;
		addrRz = 3;
		Reg2Loc = 1;
		#100;
      addrRy = 0;
		addrRz = 0;
		Reg2Loc = 0;
		

	end
      
endmodule

