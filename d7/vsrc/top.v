module top (
    input clk,
    input rst,

    input ps2_clk,
    input ps2_data,

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

  reg  [9:0] buffer;  // ps2_data bits
  reg  [3:0] count;  // count ps2_data bits
  reg  [2:0] ps2_clk_sync;

  reg  [3:0] num0;
  reg  [3:0] num1;
  // MakeCode
  reg  [3:0] num2;
  reg  [3:0] num3;
  reg  [3:0] num2out;
  reg  [3:0] num3out;

  // times
  reg  [7:0] pcount;  //press times
  wire [3:0] num4;  // show times
  wire [3:0] num5;

  assign num4 = pcount[3:0];
  assign num5 = pcount[7:4];

  reg [7:0] codebuff;
  reg [7:0] last_code;  // restore last state
  wire release_flag = (codebuff == 8'hF0) & (buffer[8:1] == last_code);
  reg [1:0] release_reg;
  reg count_ready;

  wire resetn = !rst;

  always @(posedge clk) begin
    ps2_clk_sync <= {ps2_clk_sync[1:0], ps2_clk};
  end

  wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];

  always @(posedge clk) begin
    if (resetn == 0) begin  // reset
      count <= 0;
      pcount <= 0;
      last_code <= 8'h00;
      count_ready <= 0;
    end else begin
      if (sampling) begin
        if (count == 4'd10) begin
          if ((buffer[0] == 0) &&  // start bit
              (ps2_data) &&  // stop bit
              (^buffer[9:1])) begin  // odd  parity
            $display("receive buffer %x", buffer[8:1]);
            last_code <= codebuff;
            codebuff <= buffer[8:1];
            release_reg <= {release_reg[0], release_flag};
            if (release_reg[1] & ~release_reg[0]) begin
              count_ready <= 1;
            end
            if ((count_ready) & (buffer[8:1] != 8'hF0)) begin
              // count logic
              pcount <= pcount + 1;
              count_ready <= 0;
            end
            if (codebuff != 8'hF0 & buffer[8:1] != 8'hF0) begin
              num0 <= buffer[4:1];
              num1 <= buffer[8:5];
              num2out <= num2;
              num3out <= num3;
            end else begin
              num0 <= 4'h0;
              num1 <= 4'h0;
              num2out <= 4'h0;
              num3out <= 4'h0;
            end

          end
          count <= 0;  // for next
        end else begin
          buffer[count] <= ps2_data;  // store ps2_data
          count <= count + 3'b001;
        end
      end
    end
  end



  always @(*) begin
    case (buffer[8:1])
      8'h15: begin  //Q
        num2 = 4'h1;
        num3 = 4'h5;
      end
      8'h1D: begin  //W
        num2 = 4'h7;
        num3 = 4'h5;
      end
      8'h24: begin  //E
        num2 = 4'h5;
        num3 = 4'h4;
      end
      8'h2D: begin  //R
        num2 = 4'h2;
        num3 = 4'h5;
      end
      8'h2C: begin  //T
        num2 = 4'h4;
        num3 = 4'h5;
      end
      8'h35: begin  //Y
        num2 = 4'h9;
        num3 = 4'h5;
      end
      8'h3C: begin  //U
        num2 = 4'h5;
        num3 = 4'h5;
      end
      8'h43: begin  //I
        num2 = 4'h9;
        num3 = 4'h4;
      end
      8'h44: begin  //O
        num2 = 4'hF;
        num3 = 4'h4;
      end
      8'h4D: begin  //P
        num2 = 4'h0;
        num3 = 4'h5;
      end
      8'h1C: begin  //A
        num2 = 4'h2;
        num3 = 4'h4;
      end

      8'hF0: begin  // clear
        num2 = 4'h0;
        num3 = 4'h0;
      end


      default: begin
        num2 = 4'h0;
        num3 = 4'h0;
      end
    endcase

  end

endmodule
