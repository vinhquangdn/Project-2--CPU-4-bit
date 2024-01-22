module ALU(
  input clock,
  input [3:0] A,
  input [3:0] B,
  input [3:0] aluOpcode,
  output reg [3:0] aluResult,
  output reg Zero,
  output reg Carry);
  
  reg [7:0] tempAluResult;
  

  always @(A or B or aluOpcode or posedge clock) begin
  
    case (aluOpcode)
      4'b0000 : tempAluResult = A & B;
      4'b0001 : tempAluResult = A | B;
      4'b0010 : tempAluResult = A + B;
      4'b0011 : tempAluResult = A * B;
      4'b0100 : tempAluResult = A / B;
      4'b0101 : tempAluResult = A - B;
      4'b0110 : tempAluResult = ~(A | B);
		
    endcase

	 aluResult = tempAluResult[3:0];
	 //Carry = tempAluResult[4];
	 
    if (aluResult == 4'b0)
      Zero = 1'b1;
    else
      Zero = 1'b0;
		
	 if(tempAluResult[7:4] != 4'b0 && aluOpcode != 4'b0110)
		Carry = 1'b1;
	 else 
		Carry = 1'b0;
	 
  end
endmodule
