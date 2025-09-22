//`include "segled.v"
module top (
    input clk,
    input rst,
    input [3:0] num1,
    input [3:0] num2,
    input [2:0] fun,

    output reg [3:0] outNum,
    output overflow,
    output equalZero
);

  wire [3:0] num2_ne = ~num2 + 4'b0001;
  wire [4:0] addN = {1'b0, num1} + {1'b0, num2};  //add result
  wire [4:0] subN = {1'b0, num1} + {1'b0, num2_ne};

  wire  addOvf = (num1[3] == num2[3]) && (addN[3] != num1[3]);
  wire  subOvf = (num1[3] != num2[3]) && (subN[3] != num1[3]);

  assign overflow  = (fun == 3'b000) ? addOvf : (fun == 3'b001) ? subOvf : 1'b0;

  always @(*) begin
    case (fun)
      3'b000: outNum = addN[3:0];
      3'b001: outNum = subN[3:0];
      3'b010: outNum = ~num1;
      3'b011: outNum = num1 & num2;
      3'b100: outNum = num1 | num2;
      3'b101: outNum = num1 ^ num2;
      3'b110: outNum = (num1 < num2) ? 1 : 0;
      3'b111: outNum = (num1 == num2) ? 1 : 0;

      default: outNum = 4'b0000;
    endcase
  end

  assign equalZero = (outNum == 4'b0000);
endmodule
































































