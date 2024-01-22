module DataMemMux(
  input clock,
  input [3:0] aluResult,
  input [3:0] readData,
  input MemtoReg,
  output reg [3:0] out);

  always @(posedge clock, readData, aluResult, MemtoReg, out) begin
    if (MemtoReg == 0)
      out = aluResult;
    else
      out = readData;
  end
endmodule