module FrameTrigger(
  input        clock,
  input        reset,
  input  [7:0] io_in_data,
  input        io_in_clear,
  output       io_out_trigger
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] buf_0; // @[FrameTrigger.scala 19:20]
  reg [7:0] buf_1; // @[FrameTrigger.scala 19:20]
  reg [7:0] cnt; // @[FrameTrigger.scala 20:20]
  wire [7:0] _ave_T_2 = 8'h7f - buf_0; // @[FrameTrigger.scala 25:29]
  wire [7:0] _ave_T_4 = buf_0 - 8'h7f; // @[FrameTrigger.scala 25:36]
  wire [7:0] _ave_T_5 = buf_0 < 8'h7f ? _ave_T_2 : _ave_T_4; // @[FrameTrigger.scala 25:11]
  wire [7:0] _ave_T_8 = 8'h7f - buf_1; // @[FrameTrigger.scala 25:29]
  wire [7:0] _ave_T_10 = buf_1 - 8'h7f; // @[FrameTrigger.scala 25:36]
  wire [7:0] _ave_T_11 = buf_1 < 8'h7f ? _ave_T_8 : _ave_T_10; // @[FrameTrigger.scala 25:11]
  wire [9:0] _ave_WIRE = {{2'd0}, _ave_T_5}; // @[FrameTrigger.scala 25:54 FrameTrigger.scala 25:54]
  wire [9:0] _ave_WIRE_1 = {{2'd0}, _ave_T_11}; // @[FrameTrigger.scala 25:54 FrameTrigger.scala 25:54]
  wire [9:0] ave = _ave_WIRE + _ave_WIRE_1; // @[FrameTrigger.scala 27:15]
  reg  run; // @[FrameTrigger.scala 28:20]
  reg [7:0] triggerDelay; // @[FrameTrigger.scala 30:29]
  wire [7:0] _cnt_T_1 = cnt + 8'h1; // @[FrameTrigger.scala 34:18]
  wire [7:0] _triggerDelay_T_2 = triggerDelay - 8'h1; // @[FrameTrigger.scala 42:67]
  wire  _GEN_2 = ave >= 10'h2c ? 1'h0 : run; // @[FrameTrigger.scala 38:28 FrameTrigger.scala 40:11 FrameTrigger.scala 28:20]
  wire  _GEN_5 = io_in_clear | run ? _GEN_2 : run; // @[FrameTrigger.scala 32:28 FrameTrigger.scala 28:20]
  wire  _GEN_6 = io_in_clear | _GEN_5; // @[FrameTrigger.scala 46:21 FrameTrigger.scala 47:9]
  assign io_out_trigger = triggerDelay != 8'h0; // @[FrameTrigger.scala 31:34]
  always @(posedge clock) begin
    if (reset) begin // @[FrameTrigger.scala 19:20]
      buf_0 <= 8'h7f; // @[FrameTrigger.scala 19:20]
    end else if (~cnt[0]) begin // @[FrameTrigger.scala 49:12]
      buf_0 <= io_in_data; // @[FrameTrigger.scala 49:12]
    end
    if (reset) begin // @[FrameTrigger.scala 19:20]
      buf_1 <= 8'h7f; // @[FrameTrigger.scala 19:20]
    end else if (cnt[0]) begin // @[FrameTrigger.scala 49:12]
      buf_1 <= io_in_data; // @[FrameTrigger.scala 49:12]
    end
    if (reset) begin // @[FrameTrigger.scala 20:20]
      cnt <= 8'h0; // @[FrameTrigger.scala 20:20]
    end else if (io_in_clear | run) begin // @[FrameTrigger.scala 32:28]
      if (cnt != 8'h0) begin // @[FrameTrigger.scala 33:37]
        cnt <= _cnt_T_1; // @[FrameTrigger.scala 34:11]
      end else begin
        cnt <= 8'h0; // @[FrameTrigger.scala 36:11]
      end
    end
    run <= reset | _GEN_6; // @[FrameTrigger.scala 28:20 FrameTrigger.scala 28:20]
    if (reset) begin // @[FrameTrigger.scala 30:29]
      triggerDelay <= 8'h0; // @[FrameTrigger.scala 30:29]
    end else if (io_in_clear | run) begin // @[FrameTrigger.scala 32:28]
      if (ave >= 10'h2c) begin // @[FrameTrigger.scala 38:28]
        triggerDelay <= 8'hf; // @[FrameTrigger.scala 39:20]
      end else if (triggerDelay == 8'h0) begin // @[FrameTrigger.scala 42:26]
        triggerDelay <= 8'h0;
      end else begin
        triggerDelay <= _triggerDelay_T_2;
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
  buf_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  buf_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  cnt = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  run = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  triggerDelay = _RAND_4[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FrameTriggerWrapper(
  input  [7:0] io_in_data,
  input        io_in_clear,
  output       io_out_trigger,
  input        io_clock,
  input        io_resetN
);
  wire  module__clock; // @[FrameTrigger.scala 67:24]
  wire  module__reset; // @[FrameTrigger.scala 67:24]
  wire [7:0] module__io_in_data; // @[FrameTrigger.scala 67:24]
  wire  module__io_in_clear; // @[FrameTrigger.scala 67:24]
  wire  module__io_out_trigger; // @[FrameTrigger.scala 67:24]
  FrameTrigger module_ ( // @[FrameTrigger.scala 67:24]
    .clock(module__clock),
    .reset(module__reset),
    .io_in_data(module__io_in_data),
    .io_in_clear(module__io_in_clear),
    .io_out_trigger(module__io_out_trigger)
  );
  assign io_out_trigger = module__io_out_trigger; // @[FrameTrigger.scala 69:19]
  assign module__clock = io_clock;
  assign module__reset = ~io_resetN; // @[FrameTrigger.scala 66:31]
  assign module__io_in_data = io_in_data; // @[FrameTrigger.scala 68:18]
  assign module__io_in_clear = io_in_clear; // @[FrameTrigger.scala 68:18]
endmodule
