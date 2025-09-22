module top (
    input clk,
    input rst,


    output [6:0] ledl0,
    output [6:0] ledh0,
    output [6:0] ledl1,
    output [6:0] ledh1,
    output [6:0] ledl2,
    output [6:0] ledh2
);
  seg7 seg_0 (
      .clk(clk),
      .rst(rst),
      .in (num0),
      .led(ledl0)
  );
  seg7 seg_1 (
      .clk(clk),
      .rst(rst),
      .in (num1),
      .led(ledh0)
  );
  seg7 seg_2 (
      .clk(clk),
      .rst(rst),
      .in (num2out),
      .led(ledl1)
  );
  seg7 seg_3 (
      .clk(clk),
      .rst(rst),
      .in (num3out),
      .led(ledh1)
  );
  seg7 seg_4 (
      .clk(clk),
      .rst(rst),
      .in (num4),
      .led(ledl2)
  );
  seg7 seg_5 (
      .clk(clk),
      .rst(rst),
      .in (num5),
      .led(ledh2)
  );

  wire resetn = !rst;
  reg [7:0] PC;
  reg [7:0] R[0];
  reg [7:0] R[1];
  reg [7:0] R[2];
  reg [7:0] R[3];

  reg [7:0] Mem[0] = 8'h80;
  reg [7:0] Mem[1] = 8'h90;
  reg [7:0] Mem[2] = 8'ha0;
  reg [7:0] Mem[3] = 8'hb1;
  reg [7:0] Mem[4] = 8'h17;
  reg [7:0] Mem[5] = 8'h29;
  reg [7:0] Mem[6] = 8'hcd;
  reg [7:0] Mem[7] = 8'hdb;
  always @(posedge clk) begin
    if (resetn == 0) begin
      PC   = 0;
      R[0] = 0;
      R[1] = 0;
      R[2] = 0;
      R[3] = 0;
    end else begin
	case (Mem[Pc])
		 : begin
			
		end
	default: begin
		
	
	end
	endcase



    end

  end



  always @(*) begin

  end

endmodule
