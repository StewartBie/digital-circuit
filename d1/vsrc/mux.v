module mux (
    input clk,
    input rst,
    input [1:0] X0,
    input [1:0] X1,
    input [1:0] X2,
    input [1:0] X3,
    input [1:0] Y,

    output reg [1:0] F
);

  assign F = ({2{!Y[1] & !Y[0]}} & X0)|
	    ({2{!Y[1] & Y[0]}} & X1) |
	    ({2{Y[1] & !Y[0]}} & X2) |
      ({2{Y[1] & Y[0]}} & X3)  ;

endmodule
