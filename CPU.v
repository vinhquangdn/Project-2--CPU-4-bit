`include "ALU.v"
`include "InstructionMemMux.v"
`include "DataMemMux.v"
`include "PCMux.v"
`include "RegisterMux.v"
module CPU(
  input clock, reset,
  
  output reg Reg2Loc,   //phan biet R type va others
  output reg Unconbranch,
  output reg Branch,
  output reg MemRead,
  output reg MemWrite, 
  output reg MemtoReg,
  output reg ALUSrc,
  output reg RegWrite,
  
  output reg [3:0] PC,
  output reg [15:0]Instruction,
  
  output reg [1:0] addrRx,  //dia chi cua Rx co 2 bit
  output reg [3:0] Rx,
  output reg [1:0] addrRy, 		//dia chi cua Ry co 2 bit
  output reg [3:0] Ry, 
  output reg [3:0] Immediate,
  output wire [3:0] outRegisterMux,
  output reg [1:0] addrRz,	//dia chi cua Rz co 2 bit
  output reg [3:0] Rz,
  output wire [3:0] outDataMux,
  output [3:0] aluResult,
  output reg [3:0] readData,
  output Carry,
  output Zero
  );
  
  reg [3:0] Opcode;
  reg [3:0] tempRz;
  //alu
  reg [3:0] aluOpcode;
  //wire tempZero;
  
  //mux1
  wire [3:0] nextPC;    //input
  wire [3:0] branchPC;		
  reg Jump;
  wire [3:0] nextnextPC;  //output
  
  //jump  
  wire nextPCZero;
  wire branchPCZero;
  reg tempBranch;
  
  wire nextPCCarry;
  wire branchPCCarry;
  
  wire [1:0] outInstructionMux; //dau ra cua mux la wire
  //wire [3:0] outRegisterMux;
  //wire [3:0] outDataMux;
  //reg [3:0] readData;
  reg [15:0] Ins[15:0]; //tao 16 o nho, moi o nho rong 16 bit
  reg [3:0] RegX_val[3:0]; //tao 4 o nho, moi o nho rong 4 bit
  reg [3:0] RegY_val[3:0];
  reg [3:0] RegZ_val[3:0];
  reg [3:0] Data_mem[15:0];
  reg [3:0] ReadData2;
  
  initial begin
    
    Reg2Loc = 1'bx;
    MemtoReg = 1'bx;    
	 RegWrite = 1'bx;
    MemRead = 1'bx;
    MemWrite = 1'bx;
    ALUSrc = 1'bx;
	 Instruction = 16'hx;
	 addrRx = 2'bx;
	 addrRy = 2'bx;
	 addrRz = 2'bx;
	 Rx = 4'bx;
	 Ry = 4'bx;
	 Rz = 4'bx;
	 aluOpcode = 4'bx;
	 Branch = 1'bx;
    Unconbranch = 1'bx;
    
  end
                                                                            
  //Instruction memory                                         
  initial begin
	//R type
	Ins[0] = 16'h0000;  //Rz = Rx and Ry
	Ins[1] = 16'h1014;  //Rz = Rx or Ry
	Ins[2] = 16'h2024;  //Rz = Rx add Ry
	Ins[3] = 16'h3035;  //Rz = Rx mul Ry
	Ins[4] = 16'h4000;  //Rz = Rx div Ry
	Ins[5] = 16'h5010;  //Rz = Rx sub Ry
	Ins[6] = 16'h602A;  //Rz = Rx nor Ry

	//I type
	Ins[7]  = 16'h7100;   //Rz = Rx addi immediate 
	Ins[8]  = 16'h9314;   //load data memory to Rz
	Ins[9]  = 16'h8304;   //store Rz into data memory
	Ins[10] = 16'h9314;  //load data memory to Rz

	//J type
	Ins[11] = 16'hA200;  //jump no condition                        
	Ins[13] = 16'hB23D;  //jump with condition
	Ins[14] = 16'hB23F;  //jump with condition                          

   Ins[12] = 16'hx;
	Ins[15] = 16'hx;
	end
	
	//Register file
  initial begin
   RegX_val[0] = 4'b0000; RegY_val[0] = 4'b0111; RegZ_val[0] = 4'bz;
	RegX_val[1] = 4'b0001; RegY_val[1] = 4'b1000; RegZ_val[1] = 4'bz;
	RegX_val[2] = 4'b0000; RegY_val[2] = 4'b1001; RegZ_val[2] = 4'bz;
	RegX_val[3] = 4'b0100; RegY_val[3] = 4'b0100; RegZ_val[3] = 4'bz;
	
  end
  //Data memory
  initial begin
    Data_mem[0] = 4'b0000;
    Data_mem[1] = 4'b0001;
    Data_mem[2] = 4'b0010;
    Data_mem[3] = 4'b0011;
    Data_mem[4] = 4'b0100;
	 Data_mem[5] = 4'b0101;
    Data_mem[6] = 4'b0110;
    Data_mem[7] = 4'b0111;
	 
    Data_mem[8]  = 4'b1000;
	 Data_mem[9]  = 4'b1001;
    Data_mem[10] = 4'b1010;
    Data_mem[11] = 4'b1011;
    Data_mem[12] = 4'b1100;
    Data_mem[13] = 4'b1101;
	 Data_mem[14] = 4'b1110;
    Data_mem[15] = 4'b1111;
  end

  ALU adderNextPC(clock, PC, 4'b0001, 4'b0010, nextPC, nextPCZero, nextPCCarry);  //PC lay lenh theo thu tu

  ALU adderShiftPC(clock, PC, Immediate, 4'b0010, branchPC, branchPCZero, branchPCCarry); //PC lay lenh duoc chi dinh

  PCMux mux1(clock, nextPC, branchPC, Jump, nextnextPC);  //lua chon dau ra PC

  InstructionMemMux mux2(clock, addrRy, addrRz, Reg2Loc, outInstructionMux);

  RegisterMux mux3(clock, ReadData2, Immediate, ALUSrc, outRegisterMux);
  
  ALU alu(clock, Rx, outRegisterMux, aluOpcode, aluResult, Zero, Carry);

  DataMemMux mux4(clock, aluResult, readData, MemtoReg, outDataMux);
  
  always @(posedge clock, MemRead, MemWrite, ReadData2, aluResult) begin
    if (MemWrite == 1)
        Data_mem[aluResult] = ReadData2;
    if (MemRead == 1)
        readData = Data_mem[aluResult];
		  
  end
  
  //always @(posedge clock, readData, aluResult, MemtoReg, outDataMux, RegWrite, addrRz) begin
  always @(posedge clock, readData, aluResult, MemtoReg, outDataMux, RegWrite, addrRz) begin 
	 if (RegWrite == 1) begin
      RegZ_val[addrRz] = outDataMux;
    end
	 Rz = RegZ_val[addrRz];
  end
  
  always @(posedge clock, outInstructionMux, Reg2Loc) begin
	 
    if (Reg2Loc == 0)
		ReadData2 = RegY_val[outInstructionMux];
	 else
      ReadData2 = RegZ_val[outInstructionMux];	
	end

  //always @(posedge clock, posedge reset, Unconbranch, Branch, tempBranch, Jump) begin
  always @(posedge clock, posedge reset, Unconbranch, Branch, tempBranch, Zero, Jump) begin	 
	 tempBranch = Zero & Branch;
	 Jump = Unconbranch | tempBranch;
    if (reset)
		PC = 4'b0;
	 else 
      PC =  nextnextPC;
	 
  end
  
  
  always @(posedge clock) begin
  
	 Instruction = Ins[PC];
	 Opcode = Instruction[15:12];
	 Immediate = Instruction[11:8];
    addrRy = Instruction[1:0];
	 addrRx = Instruction[3:2];
    addrRz = Instruction[5:4];
	 Ry = RegY_val[addrRy];
	 Rx = RegX_val[addrRx];
	 //tempData = readData;
	 
	 
	 //R-type
    if (Opcode >= 4'b0 && Opcode <= 4'b0110) begin
      aluOpcode = Opcode;
      Reg2Loc = 1'b0;
		Unconbranch = 1'b0;
		Branch = 1'b0;
		MemRead = 1'bx;
      MemWrite = 1'bx;
      MemtoReg = 1'b0;
		ALUSrc = 1'b0;
      RegWrite = 1'b1;
      end
		
	 //I-type
    else if (Opcode == 4'b0111) begin // Opcode for ADDI
      aluOpcode = 4'b0010;  //su dung mach cong cua alu de cong Rx va Ry
      Reg2Loc = 1'bx;
		Unconbranch = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b0;
      MemWrite = 1'b0 ;
      MemtoReg = 1'b0;
		ALUSrc = 1'b1;
      RegWrite = 1'b1;
      end
    else if (Opcode == 4'b1000) begin // Opcode for STUR
      aluOpcode = 4'b0010;		//su dung mach cong cua alu de cong Rx va Ry
      Reg2Loc = 1'b1;
		Unconbranch = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b0;
      MemWrite = 1'b1;
      MemtoReg = 1'bx;
		ALUSrc = 1'b1;
      RegWrite = 1'b0;
      end
    else if (Opcode == 4'b1001) begin // Opcode for LDUR
      aluOpcode = 4'b0010;		//su dung mach cong cua alu de cong Rx va Ry
      Reg2Loc = 1'bx;
		Unconbranch = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b1;
      MemWrite = 1'b0;
      MemtoReg = 1'b1;
		ALUSrc = 1'b1;
      RegWrite = 1'b1;
      end

    //J-type
    else if (Opcode == 4'b1010) begin // Opcode for B
		aluOpcode = 4'b0010; //add
      Reg2Loc = 1'b0;
		Unconbranch = 1'b1;
		Branch = 1'b0;
		MemRead = 1'b0;
      MemWrite = 1'b0;
      MemtoReg = 1'bx;
		ALUSrc = 1'b0;
      RegWrite = 1'b0;
      end 
    else if (Opcode == 4'b1011) begin // Opcode for BZ
	   aluOpcode = 4'b0101; //sub
      Reg2Loc = 1'b0;
		Unconbranch = 1'b0;
		Branch = 1'b1;
		MemRead = 1'b0;
      MemWrite = 1'b0;
      MemtoReg = 1'bx;
		ALUSrc = 1'b0;
      RegWrite = 1'b0;
      end
	  
	 
	else begin
		aluOpcode = Opcode;
      Reg2Loc = 1'b0;
		Unconbranch = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b0;
      MemWrite = 1'b0;
      MemtoReg = 1'b0;
		ALUSrc = 1'b0;
      RegWrite = 1'b0;
		end
	
  end
endmodule