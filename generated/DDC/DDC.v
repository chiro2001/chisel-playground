module DDC(
  input         clock,
  input         reset,
  input  [7:0]  io_in_data,
  input         io_in_sync,
  output        io_out_data,
  output [7:0]  io_out_readData,
  output [15:0] io_out_value
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] yListMul_0; // @[DDC.scala 47:25]
  reg [15:0] yListMul_1; // @[DDC.scala 47:25]
  reg [15:0] yListMul_2; // @[DDC.scala 47:25]
  reg [15:0] yListMul_3; // @[DDC.scala 47:25]
  reg [15:0] yListMul_4; // @[DDC.scala 47:25]
  reg [15:0] yListMul_5; // @[DDC.scala 47:25]
  reg [15:0] yListMul_6; // @[DDC.scala 47:25]
  reg [2:0] cnt; // @[DDC.scala 49:20]
  reg  run; // @[DDC.scala 50:20]
  reg  out; // @[DDC.scala 65:20]
  wire [15:0] _yListMul_0_T_4 = $signed(io_out_readData) * 8'sh0; // @[DDC.scala 71:84]
  wire [15:0] _ave_T_2 = $signed(yListMul_0) + $signed(yListMul_1); // @[DDC.scala 57:33]
  wire [15:0] _ave_T_5 = $signed(_ave_T_2) + $signed(yListMul_2); // @[DDC.scala 57:33]
  wire [15:0] _ave_T_8 = $signed(_ave_T_5) + $signed(yListMul_3); // @[DDC.scala 57:33]
  wire [15:0] _ave_T_11 = $signed(_ave_T_8) + $signed(yListMul_4); // @[DDC.scala 57:33]
  wire [15:0] _ave_T_14 = $signed(_ave_T_11) + $signed(yListMul_5); // @[DDC.scala 57:33]
  wire [15:0] ave = $signed(_ave_T_14) + $signed(yListMul_6); // @[DDC.scala 57:33]
  wire  _T_1 = $signed(ave) > 16'sh0; // @[DDC.scala 58:15]
  wire [2:0] _cnt_T_1 = cnt + 3'h1; // @[DDC.scala 81:20]
  wire  _GEN_2 = cnt == 3'h5 ? 1'h0 : run; // @[DDC.scala 76:26 DDC.scala 78:13 DDC.scala 50:20]
  wire [7:0] _io_out_readData_T_2 = io_in_data - 8'h7f; // @[DDC.scala 38:39]
  wire [7:0] _io_out_readData_T_5 = 8'h7f - io_in_data; // @[DDC.scala 40:40]
  wire [7:0] _io_out_readData_T_8 = 8'sh0 - $signed(_io_out_readData_T_5); // @[DDC.scala 40:18]
  wire [7:0] _GEN_4 = io_in_data > 8'h7f ? $signed(_io_out_readData_T_2) : $signed(_io_out_readData_T_8); // @[DDC.scala 37:23 DDC.scala 38:15 DDC.scala 40:15]
  wire [7:0] _GEN_6 = 3'h1 == cnt ? $signed(8'sh6d) : $signed(8'sh0); // @[DDC.scala 84:60 DDC.scala 84:60]
  wire [7:0] _GEN_7 = 3'h2 == cnt ? $signed(8'sh6d) : $signed(_GEN_6); // @[DDC.scala 84:60 DDC.scala 84:60]
  wire [7:0] _GEN_8 = 3'h3 == cnt ? $signed(8'sh0) : $signed(_GEN_7); // @[DDC.scala 84:60 DDC.scala 84:60]
  wire [7:0] _GEN_9 = 3'h4 == cnt ? $signed(-8'sh6d) : $signed(_GEN_8); // @[DDC.scala 84:60 DDC.scala 84:60]
  wire [7:0] _mul_T_1 = 3'h5 == cnt ? $signed(-8'sh6d) : $signed(_GEN_9); // @[DDC.scala 84:60]
  wire [15:0] mul = $signed(io_out_readData) * $signed(_mul_T_1); // @[DDC.scala 84:81]
  wire [15:0] _io_out_value_T = $signed(io_out_readData) * $signed(_mul_T_1); // @[DDC.scala 86:35]
  wire  _GEN_19 = run ? _GEN_2 : run; // @[DDC.scala 75:16 DDC.scala 50:20]
  wire [7:0] _GEN_21 = run ? $signed(_GEN_4) : $signed(8'sh0); // @[DDC.scala 75:16 DDC.scala 68:19]
  wire [15:0] _GEN_29 = run ? _io_out_value_T : 16'h0; // @[DDC.scala 75:16 DDC.scala 86:20 DDC.scala 67:16]
  wire  _GEN_32 = io_in_sync | _GEN_19; // @[DDC.scala 70:21 DDC.scala 73:9]
  assign io_out_data = out; // @[DDC.scala 90:15]
  assign io_out_readData = io_in_sync ? $signed(8'sh0) : $signed(_GEN_21); // @[DDC.scala 70:21 DDC.scala 68:19]
  assign io_out_value = io_in_sync ? 16'h0 : _GEN_29; // @[DDC.scala 70:21 DDC.scala 67:16]
  always @(posedge clock) begin
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_0 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (io_in_sync) begin // @[DDC.scala 70:21]
      yListMul_0 <= _yListMul_0_T_4; // @[DDC.scala 71:19]
    end else if (run) begin // @[DDC.scala 75:16]
      if (3'h0 == cnt) begin // @[DDC.scala 85:21]
        yListMul_0 <= mul; // @[DDC.scala 85:21]
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_1 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h1 == cnt) begin // @[DDC.scala 85:21]
          yListMul_1 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_2 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h2 == cnt) begin // @[DDC.scala 85:21]
          yListMul_2 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_3 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h3 == cnt) begin // @[DDC.scala 85:21]
          yListMul_3 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_4 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h4 == cnt) begin // @[DDC.scala 85:21]
          yListMul_4 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_5 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h5 == cnt) begin // @[DDC.scala 85:21]
          yListMul_5 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 47:25]
      yListMul_6 <= 16'sh0; // @[DDC.scala 47:25]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (3'h6 == cnt) begin // @[DDC.scala 85:21]
          yListMul_6 <= mul; // @[DDC.scala 85:21]
        end
      end
    end
    if (reset) begin // @[DDC.scala 49:20]
      cnt <= 3'h0; // @[DDC.scala 49:20]
    end else if (io_in_sync) begin // @[DDC.scala 70:21]
      cnt <= 3'h1; // @[DDC.scala 72:9]
    end else if (run) begin // @[DDC.scala 75:16]
      if (cnt == 3'h5) begin // @[DDC.scala 76:26]
        cnt <= 3'h0; // @[DDC.scala 77:13]
      end else begin
        cnt <= _cnt_T_1; // @[DDC.scala 81:13]
      end
    end
    if (reset) begin // @[DDC.scala 50:20]
      run <= 1'h0; // @[DDC.scala 50:20]
    end else begin
      run <= _GEN_32;
    end
    if (reset) begin // @[DDC.scala 65:20]
      out <= 1'h0; // @[DDC.scala 65:20]
    end else if (!(io_in_sync)) begin // @[DDC.scala 70:21]
      if (run) begin // @[DDC.scala 75:16]
        if (cnt == 3'h5) begin // @[DDC.scala 76:26]
          out <= _T_1;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  yListMul_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  yListMul_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  yListMul_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  yListMul_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  yListMul_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  yListMul_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  yListMul_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  cnt = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  run = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  out = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
