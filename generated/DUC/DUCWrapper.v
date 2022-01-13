module DUC(
  input        clock,
  input        reset,
  input        io_in_data,
  input        io_in_sync,
  output [7:0] io_out_dac
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  data; // @[DUC.scala 35:21]
  reg  run; // @[DUC.scala 39:20]
  reg [7:0] cnt; // @[DUC.scala 40:20]
  wire [1:0] _io_out_dac_T = data ? $signed(2'sh1) : $signed(-2'sh1); // @[DUC.scala 37:53]
  wire [9:0] _io_out_dac_T_1 = 8'sh0 * $signed(_io_out_dac_T); // @[DUC.scala 37:48]
  wire [9:0] _io_out_dac_T_5 = $signed(_io_out_dac_T_1) + 10'sh7f; // @[DUC.scala 37:89]
  wire [7:0] _GEN_0 = io_in_sync ? _io_out_dac_T_5[7:0] : 8'h0; // @[DUC.scala 42:21 DUC.scala 43:16 DUC.scala 41:14]
  wire  _GEN_1 = io_in_sync | run; // @[DUC.scala 42:21 DUC.scala 44:9 DUC.scala 39:20]
  wire [7:0] _cnt_T_1 = cnt + 8'h1; // @[DUC.scala 53:18]
  wire [7:0] _GEN_7 = 3'h1 == cnt[2:0] ? $signed(8'sh6d) : $signed(8'sh0); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [7:0] _GEN_8 = 3'h2 == cnt[2:0] ? $signed(8'sh6d) : $signed(_GEN_7); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [7:0] _GEN_9 = 3'h3 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_8); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [7:0] _GEN_10 = 3'h4 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_9); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [7:0] _GEN_11 = 3'h5 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_10); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [7:0] _GEN_12 = 3'h6 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_11); // @[DUC.scala 37:48 DUC.scala 37:48]
  wire [9:0] _io_out_dac_T_8 = $signed(_GEN_12) * $signed(_io_out_dac_T); // @[DUC.scala 37:48]
  wire [9:0] _io_out_dac_T_12 = $signed(_io_out_dac_T_8) + 10'sh7f; // @[DUC.scala 37:89]
  assign io_out_dac = run ? _io_out_dac_T_12[7:0] : _GEN_0; // @[DUC.scala 48:14 DUC.scala 55:16]
  always @(posedge clock) begin
    if (reset) begin // @[DUC.scala 35:21]
      data <= 1'h0; // @[DUC.scala 35:21]
    end else if (io_in_sync) begin // @[DUC.scala 42:21]
      data <= io_in_data; // @[DUC.scala 46:10]
    end
    if (reset) begin // @[DUC.scala 39:20]
      run <= 1'h0; // @[DUC.scala 39:20]
    end else if (run) begin // @[DUC.scala 48:14]
      if (cnt == 8'h5) begin // @[DUC.scala 49:40]
        run <= io_in_sync; // @[DUC.scala 51:11]
      end else begin
        run <= _GEN_1;
      end
    end else begin
      run <= _GEN_1;
    end
    if (reset) begin // @[DUC.scala 40:20]
      cnt <= 8'h0; // @[DUC.scala 40:20]
    end else if (run) begin // @[DUC.scala 48:14]
      if (cnt == 8'h5) begin // @[DUC.scala 49:40]
        cnt <= 8'h0; // @[DUC.scala 50:11]
      end else begin
        cnt <= _cnt_T_1; // @[DUC.scala 53:11]
      end
    end else if (io_in_sync) begin // @[DUC.scala 42:21]
      cnt <= 8'h0; // @[DUC.scala 45:9]
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
  data = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  run = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  cnt = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DUCWrapper(
  input        io_in_data,
  input        io_in_sync,
  output [7:0] io_out_dac,
  input        io_clock,
  input        io_resetN
);
  wire  module__clock; // @[DUC.scala 74:24]
  wire  module__reset; // @[DUC.scala 74:24]
  wire  module__io_in_data; // @[DUC.scala 74:24]
  wire  module__io_in_sync; // @[DUC.scala 74:24]
  wire [7:0] module__io_out_dac; // @[DUC.scala 74:24]
  DUC module_ ( // @[DUC.scala 74:24]
    .clock(module__clock),
    .reset(module__reset),
    .io_in_data(module__io_in_data),
    .io_in_sync(module__io_in_sync),
    .io_out_dac(module__io_out_dac)
  );
  assign io_out_dac = module__io_out_dac; // @[DUC.scala 76:19]
  assign module__clock = io_clock;
  assign module__reset = ~io_resetN; // @[DUC.scala 73:31]
  assign module__io_in_data = io_in_data; // @[DUC.scala 75:18]
  assign module__io_in_sync = io_in_sync; // @[DUC.scala 75:18]
endmodule
