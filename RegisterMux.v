module RegisterMux(
  input clock,
  input [3:0] ReadData2,
  input [3:0] Immediate,
  input ALUSrc,
  output reg [3:0] out);

  always @(posedge clock, ReadData2, Immediate, ALUSrc, out) begin

    if (ALUSrc == 0) begin
      out = ReadData2;
    end

    else begin
      out = Immediate;
    end
  end
endmodule