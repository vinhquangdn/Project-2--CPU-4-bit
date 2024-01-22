`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:35:03 11/12/2023
// Design Name:   CPU
// Module Name:   D:/VinhQuang/Fourth_year_1/Project 2/cpu_test_PC/cpu_4bit/CPU_tb.v
// Project Name:  cpu_4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_tb;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire Reg2Loc;
	wire Unconbranch;
	wire Branch;
	wire MemRead;
	wire MemWrite;
	wire MemtoReg;
	wire ALUSrc;
	wire RegWrite;
	wire [3:0] PC;
	wire [15:0] Instruction;
	wire [1:0] addrRx;
	wire [3:0] Rx;
	wire [1:0] addrRy;
	wire [3:0] Ry;
	wire [3:0] Immediate;
	wire [3:0] outRegisterMux;
	wire [1:0] addrRz;
	wire [3:0] Rz;
	wire [3:0] outDataMux;
	wire [3:0] aluResult;
	wire [3:0] readData;
	wire Carry;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clock(clock), 
		.reset(reset),
		.Reg2Loc(Reg2Loc), 
		.Unconbranch(Unconbranch), 
		.Branch(Branch), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.MemtoReg(MemtoReg), 
		.ALUSrc(ALUSrc), 
		.RegWrite(RegWrite), 
		.PC(PC), 
		.Instruction(Instruction), 
		.addrRx(addrRx), 
		.Rx(Rx), 
		.addrRy(addrRy), 
		.Ry(Ry), 
		.Immediate(Immediate),
		.outRegisterMux(outRegisterMux),
		.addrRz(addrRz), 
		.Rz(Rz), 
		.outDataMux(outDataMux),
		.aluResult(aluResult),
		.readData(readData),
		.Carry(Carry),
		.Zero(Zero)
	);
	
	always begin
	#50 clock = !clock;
	end
	initial begin
		// Initialize Inputs
		
		clock = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
      
		// Add stimulus here

	end
      
endmodule

