//`include "segled.v"
module top (
    input clk,
    input rst,
    input [3:0] num1,
    input [3:0] num2,
    input [2:0] fun,

    output reg [3:0] outNum,
    output overflow,
    output equalZero,
    output Carry
);
  wire AddCarry;
  wire SubCarry;
  wire addOvf;
  wire subOvf;
  wire [3:0] addResult;
  wire [3:0] subResult;
  wire [3:0] Result;
  wire Cin = fun[0];

  wire [3:0] t_no_Cin;
  // subtract
  assign t_no_Cin = {4{Cin}} ^ num2;
  assign {SubCarry, subResult} = num1 + t_no_Cin + Cin;
  assign subOvf = (num1[3] == t_no_Cin[3]) && (subResult[3] != num1[3]);  //overflow
  assign {AddCarry, addResult} = {1'b0, num1} + {1'b0, num2} + Cin;  //add result
  assign addOvf = (num1[3] == num2[3]) && (addResult[3] != num1[3]);

  assign overflow = (fun == 3'b000) ? addOvf : (fun == 3'b001) ? subOvf : 1'b0;
  assign Result = (fun == 3'b000) ? addResult : (fun == 3'b001) ? subResult : 1'b0;
  assign Carry = (fun == 3'b000) ? AddCarry : (fun == 3'b001) ? SubCarry : 1'b0;

  assign equalZero = ~(|Result);

  always @(*) begin
    case (fun)
      3'b000: outNum = addResult;
      3'b001: outNum = subResult;
      3'b010: outNum = ~num1;
      3'b011: outNum = num1 & num2;
      3'b100: outNum = num1 | num2;
      3'b101: outNum = num1 ^ num2;
      3'b110: outNum = {3'b000, (!SubCarry)};
      3'b111: outNum = {3'b000, equalZero};

      default: outNum = 4'b0000;
    endcase
  end

endmodule


