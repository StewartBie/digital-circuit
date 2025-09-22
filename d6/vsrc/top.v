module top (
    input clk,
    input rst,

    input btn,
    input rst_btn,

    output [6:0] ledl,
    output [6:0] ledh
);
  reg [7:0] REG;
  // 低电平 异步复位
  always @(posedge btn or negedge rst_btn) begin
    if (rst_btn == 0) begin
      REG <= 8'h1;
    end else begin
      REG <= {{REG[4] ^ REG[3] ^ REG[2] ^ REG[0]}, REG[7:1]};
    end
  end

  seg7 ins0 (
      .clk(clk),
      .rst(rst),
      .in (REG[3:0]),
      .led(ledl[6:0])
  );
  seg7 ins1 (
      .clk(clk),
      .rst(rst),
      .in (REG[7:4]),
      .led(ledh[6:0])
  );
endmodule
