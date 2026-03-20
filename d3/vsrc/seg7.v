module seg7 (
    input clk,
    input rst,

    input  [3:0] in,
    output [6:0] led
);
  //低电平亮
  assign led[0] = !((in == 4'h0) ||(in == 4'h2)|(in == 4'h3)||(in == 4'h5)|| (in == 4'h6)
  ||(in == 4'h7)||(in == 4'h8)||(in == 4'h9)||(in == 4'ha)||(in == 4'he)||(in == 4'hf));

  assign led[1] = !((in == 4'h0) ||(in == 4'h1)||(in == 4'h2)||(in == 4'h3)|| (in == 4'h4)
  ||(in == 4'h7)||(in == 4'h8)||(in == 4'h9)||(in == 4'ha)||(in == 4'hd));

  assign led[2] = !((in == 4'h0) ||(in == 4'h1)||(in == 4'h3)|| (in == 4'h4) || (in == 4'h5)
  ||(in == 4'h6) || (in == 4'h7)||(in == 4'h8)||(in == 4'h9)||(in == 4'ha)||(in == 4'hb)
  ||(in == 4'hd));

  assign led[3] = !((in == 4'h0) || (in == 4'h2) || (in == 4'h3) || (in == 4'h5) || (in == 4'h6)
  ||(in == 4'h8)||(in == 4'hb)||(in == 4'hc)||(in == 4'hd)||(in == 4'he));

  assign led[4] = !((in == 4'h0) || (in == 4'h2) || (in == 4'h6)||(in == 4'h8)||(in == 4'ha)
  ||(in == 4'hb)||(in == 4'hc)||(in == 4'hd)||(in == 4'he)||(in == 4'hf));

  assign led[5] = !((in == 4'h0) || (in == 4'h4) || (in == 4'h5) || (in == 4'h6)||(in == 4'h8)
  ||(in == 4'h9)||(in == 4'ha)||(in == 4'hb)||(in == 4'he)||(in == 4'hf));

  assign led[6] = !((in == 4'h2) || (in == 4'h3) || (in == 4'h4) || (in == 4'h5) || (in == 4'h6)
  || (in == 4'h8) || (in == 4'h9) || (in == 4'ha) || (in == 4'hb) || (in == 4'hc) || (in == 4'hd)
  ||(in == 4'he) || (in == 4'hf));

endmodule


