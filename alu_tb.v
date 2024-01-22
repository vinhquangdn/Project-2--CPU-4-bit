`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:42:54 12/08/2023
// Design Name:   ALU
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_test_PC/cpu_4bit/alu_tb.v
// Project Name:  cpu_4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "ALU.v"
module alu_tb;

	// Inputs
	reg clock;
	reg [3:0] A;
	reg [3:0] B;
	reg [3:0] aluOpcode;

	// Outputs
	wire [3:0] aluResult;
	wire Zero;
	wire Carry;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.clock(clock), 
		.A(A), 
		.B(B), 
		.aluOpcode(aluOpcode), 
		.aluResult(aluResult), 
		.Zero(Zero), 
		.Carry(Carry)
	);

	always begin
	#50 clock = !clock;
	end
	
	initial begin
		// Initialize Inputs
		clock = 1;
		A = 9;
		B = 3;
		aluOpcode = 0;
		
		#100;
      A = 9;
		B = 3;
		aluOpcode = 4'b0001;
		
		#100;
      A = 9;
		B = 3;
		aluOpcode = 4'b0010;
		
		#100;
      A = 9;
		B = 3;
		aluOpcode = 4'b0011;
		
		#100;
      A = 9;
		B = 3;
		aluOpcode = 4'b0100;
		
		#100;
      A = 9;
		B = 9;
		aluOpcode = 4'b0101;
		
		#100;
      A = 15;
		B = 15;
		aluOpcode = 4'b0110;
		
		#100;
      A = 1;
		B = 1;
		aluOpcode = 4'b0000;
	end
      
endmodule

