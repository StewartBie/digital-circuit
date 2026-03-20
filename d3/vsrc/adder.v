module adder (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Res,
    output Cout,
    output Overflow
);

  wire [3:0] G;
  wire [3:0] P;

  wire C1, C2, C3, C4;

  // Generate & Propagate
  assign G = A & B;
  assign P = A ^ B;

  // Carry equations
  assign C1 = G[0] | (P[0] & Cin);

  assign C2 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);

  assign C3 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);

  assign C4 = G[3] |
           (P[3] & G[2]) |
           (P[3] & P[2] & G[1]) |
           (P[3] & P[2] & P[1] & G[0]) |
           (P[3] & P[2] & P[1] & P[0] & Cin);

  // Result
  assign Res[0] = P[0] ^ Cin;
  assign Res[1] = P[1] ^ C1;
  assign Res[2] = P[2] ^ C2;
  assign Res[3] = P[3] ^ C3;

  assign Cout = C4;
  assign Overflow = C3 ^ C4;

endmodule
