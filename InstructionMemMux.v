module InstructionMemMux(
  input clock,
  input [1:0] addrRy,
  input [1:0] addrRz,
  input Reg2Loc,
  output reg [1:0] out);

  always @(posedge clock, addrRy, addrRz, Reg2Loc) begin

    if (Reg2Loc == 0)
      out = addrRy;
    else
      out = addrRz;
  end
endmodule