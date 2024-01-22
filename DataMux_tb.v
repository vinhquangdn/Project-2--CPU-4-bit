`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:28:13 01/10/2024
// Design Name:   DataMemMux
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_final/cpu4bit/DataMux_tb.v
// Project Name:  cpu4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemMux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include"DataMemMux.v"
module DataMux_tb;

	// Inputs
	reg clock;
	reg [3:0] aluResult;
	reg [3:0] readData;
	reg MemtoReg;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	DataMemMux uut (
		.clock(clock),
		.aluResult(aluResult), 
		.readData(readData), 
		.MemtoReg(MemtoReg), 
		.out(out)
	);
	always begin
	#50 clock = !clock;
	end
	initial begin
		// Initialize Inputs
		clock = 1;
		readData = 5;
		aluResult = 2;
		MemtoReg = 0;

		// Wait 100 ns for global reset to finish
		#100;
      readData = 5;
		aluResult = 2;
		MemtoReg = 1;
		#100;
      readData = 6;
		aluResult = 3;
		MemtoReg = 0;
		#100;
      readData = 6;
		aluResult = 3;
		MemtoReg = 1;
		#100;
      readData = 0;
		aluResult = 0;
		MemtoReg = 0;
	end
      
endmodule

