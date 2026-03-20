//`include "segled.v"
module top (
    input [3:0] A,
    input [3:0] B,
    input [2:0] op,
    input clk,
    input rst,

    output Cout,
    output Overflow,
    output Zero,
    output [6:0] ledA,
    output [6:0] ledB,
    output [6:0] ledR
);

  wire [3:0] B_xor;
  wire Cin;
  wire [3:0] Sum;
  wire add_Cout;
  reg [3:0] Result;

  // 判断是否减法
  wire sub = (op == 3'b001);

  // 构造加/减法输入
  assign B_xor = B ^ {4{sub}};
  assign Cin   = sub;

  adder u_adder (
      .A(A),
      .B(B_xor),
      .Cin(Cin),
      .Res(Sum),
      .Cout(add_Cout),
      .Overflow(Overflow)
  );

  seg7 u_segA (
      .clk(clk),
      .rst(rst),
      .in (A),
      .led(ledA)
  );
  seg7 u_segB (
      .clk(clk),
      .rst(rst),
      .in (B),
      .led(ledB)
  );
  seg7 u_segR (
      .clk(clk),
      .rst(rst),
      .in (Result),
      .led(ledR)
  );
  // Overflow（有符号）

  assign Cout = add_Cout;

  // Zero 标志
  assign Zero = !(|Result );

  // A < B signed
  wire slt;  //smaller than
  assign slt = Sum[3] ^ Overflow;

  // A == B
  wire eq;
  assign eq = (A == B);


  // ALU 多路选择

  always @(*) begin
    case (op)
      3'b000: Result = Sum;  // A + B
      3'b001: Result = Sum;  // A - B
      3'b010: Result = ~A;  // NOT A
      3'b011: Result = A & B;  // AND
      3'b100: Result = A | B;  // OR
      3'b101: Result = A ^ B;  // XOR

      3'b110: Result = {3'b000, slt};  // SLT

      3'b111: Result = {3'b000, eq};  // EQ

      default: Result = 4'b0000;
    endcase
  end

endmodule
