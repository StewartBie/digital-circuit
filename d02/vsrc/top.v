module top (
    input clk,
    input rst,

    input  [7:0] in,
    output [6:0] led
);
  wire [2:0] line;
  encoder83 inst1 (
      .in (in),
      .out(line)
  );
  decoderled7 inst2 (
      .in (line),
      .led(led)
  );

endmodule

module encoder83 (
    input [7:0] in,
    output reg [2:0] out
);

  always @(*) begin
    if (in[7] == 1) begin
      out = 3'b111;
    end else if (in[6] == 1) begin
      out = 3'b110;
    end else if (in[5] == 1) begin
      out = 3'b101;
    end else if (in[4] == 1) begin
      out = 3'b100;
    end else if (in[3] == 1) begin
      out = 3'b011;
    end else if (in[2] == 1) begin
      out = 3'b010;
    end else if (in[1] == 1) begin
      out = 3'b001;
    end else if (in[0] == 1) begin
      out = 3'b000;
    end else begin
      out = 000;
    end
  end

endmodule

module decoderled7 (
    input  [2:0] in,
    output [6:0] led
);

  assign led[0] = (in == 3'h0) ||(in == 3'h2)|(in == 3'h3)|(in == 3'h5)|| (in == 3'h6)||(in == 3'h7);
  assign led[1] = (in == 3'h0) ||(in == 3'h1)||(in == 3'h2)||(in == 3'h3)|| (in == 3'h4)||(in == 3'h7);
  assign led[2] = (in == 3'h0) ||(in == 3'h1)||(in == 3'h3)|| (in == 3'h4)||(in == 3'h5)||(in == 3'h6)||(in == 3'h7);
  assign led[3] = (in == 3'h0) || (in == 3'h2) || (in == 3'h3) || (in == 3'h5) || (in == 3'h6);
  assign led[4] = (in == 3'h0) || (in == 3'h2) || (in == 3'h6);
  assign led[5] = (in == 3'h0) || (in == 3'h4) || (in == 3'h5) || (in == 3'h6);
  assign led[6] = (in == 3'h2) || (in == 3'h3) || (in == 3'h4) || (in == 3'h5) || (in == 3'h6);
endmodule
