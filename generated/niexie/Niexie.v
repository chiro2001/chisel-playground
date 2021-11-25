module NiexieDisplay(
  input        clock,
  input        reset,
  input  [7:0] io_in_values_0,
  input  [7:0] io_in_values_1,
  output [7:0] io_out_ledCx,
  output [7:0] io_out_ledEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] cnt; // @[Niexie.scala 18:20]
  reg [31:0] tim; // @[Niexie.scala 19:20]
  wire  flash = tim == 32'h4; // @[Niexie.scala 40:19]
  wire [7:0] _cnt_T_2 = cnt + 8'h1; // @[Niexie.scala 42:47]
  wire [31:0] _tim_T_1 = tim + 32'h1; // @[Niexie.scala 43:30]
  wire [255:0] _io_out_ledEn_T = 256'h1 << cnt; // @[Niexie.scala 44:23]
  wire [7:0] _GEN_1 = 3'h1 == cnt[2:0] ? io_in_values_1 : io_in_values_0; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_2 = 3'h2 == cnt[2:0] ? 8'hff : _GEN_1; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_3 = 3'h3 == cnt[2:0] ? 8'hff : _GEN_2; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_4 = 3'h4 == cnt[2:0] ? 8'hff : _GEN_3; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_5 = 3'h5 == cnt[2:0] ? 8'hff : _GEN_4; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_6 = 3'h6 == cnt[2:0] ? 8'hff : _GEN_5; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _GEN_7 = 3'h7 == cnt[2:0] ? 8'hff : _GEN_6; // @[Mux.scala 80:60 Mux.scala 80:60]
  wire [7:0] _io_out_ledCx_T_2 = 8'h0 == _GEN_7 ? 8'h3f : 8'h0; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_4 = 8'h1 == _GEN_7 ? 8'h6 : _io_out_ledCx_T_2; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_6 = 8'h2 == _GEN_7 ? 8'h5b : _io_out_ledCx_T_4; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_8 = 8'h3 == _GEN_7 ? 8'h4f : _io_out_ledCx_T_6; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_10 = 8'h4 == _GEN_7 ? 8'h66 : _io_out_ledCx_T_8; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_12 = 8'h5 == _GEN_7 ? 8'h6d : _io_out_ledCx_T_10; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_14 = 8'h6 == _GEN_7 ? 8'h7d : _io_out_ledCx_T_12; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_16 = 8'h7 == _GEN_7 ? 8'h7 : _io_out_ledCx_T_14; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_18 = 8'h8 == _GEN_7 ? 8'h7f : _io_out_ledCx_T_16; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_20 = 8'h9 == _GEN_7 ? 8'h67 : _io_out_ledCx_T_18; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_22 = 8'ha == _GEN_7 ? 8'h77 : _io_out_ledCx_T_20; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_24 = 8'hb == _GEN_7 ? 8'h7c : _io_out_ledCx_T_22; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_26 = 8'hc == _GEN_7 ? 8'h58 : _io_out_ledCx_T_24; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_28 = 8'hd == _GEN_7 ? 8'h5e : _io_out_ledCx_T_26; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_30 = 8'he == _GEN_7 ? 8'h79 : _io_out_ledCx_T_28; // @[Mux.scala 80:57]
  wire [7:0] _io_out_ledCx_T_32 = 8'hf == _GEN_7 ? 8'h71 : _io_out_ledCx_T_30; // @[Mux.scala 80:57]
  assign io_out_ledCx = ~_io_out_ledCx_T_32; // @[Niexie.scala 45:19]
  assign io_out_ledEn = _io_out_ledEn_T[7:0]; // @[Niexie.scala 44:16]
  always @(posedge clock) begin
    if (reset) begin // @[Niexie.scala 18:20]
      cnt <= 8'h0; // @[Niexie.scala 18:20]
    end else if (flash) begin // @[Niexie.scala 42:13]
      if (cnt == 8'h7) begin // @[Niexie.scala 42:24]
        cnt <= 8'h0;
      end else begin
        cnt <= _cnt_T_2;
      end
    end
    if (reset) begin // @[Niexie.scala 19:20]
      tim <= 32'h0; // @[Niexie.scala 19:20]
    end else if (flash) begin // @[Niexie.scala 43:13]
      tim <= 32'h0;
    end else begin
      tim <= _tim_T_1;
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
  cnt = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  tim = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Niexie(
  input        clock,
  input        reset,
  input        io_in_button,
  output [7:0] io_out_ledCx,
  output [7:0] io_out_ledEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  niexieDisplay_clock; // @[Niexie.scala 98:29]
  wire  niexieDisplay_reset; // @[Niexie.scala 98:29]
  wire [7:0] niexieDisplay_io_in_values_0; // @[Niexie.scala 98:29]
  wire [7:0] niexieDisplay_io_in_values_1; // @[Niexie.scala 98:29]
  wire [7:0] niexieDisplay_io_out_ledCx; // @[Niexie.scala 98:29]
  wire [7:0] niexieDisplay_io_out_ledEn; // @[Niexie.scala 98:29]
  reg  started; // @[Niexie.scala 61:24]
  wire  _dismiss_T = ~started; // @[Niexie.scala 62:33]
  wire  dismiss = io_in_button | ~started; // @[Niexie.scala 62:30]
  wire [15:0] _T_4 = 16'hffff - 16'h1; // @[Niexie.scala 71:43]
  wire  hi_hi_hi = _T_4[0]; // @[Niexie.scala 73:40]
  wire  hi_hi_lo = _T_4[1]; // @[Niexie.scala 73:40]
  wire  hi_lo_hi = _T_4[2]; // @[Niexie.scala 73:40]
  wire  hi_lo_lo = _T_4[3]; // @[Niexie.scala 73:40]
  wire  lo_hi_hi = _T_4[4]; // @[Niexie.scala 73:40]
  wire  lo_hi_lo = _T_4[5]; // @[Niexie.scala 73:40]
  wire  lo_lo_hi = _T_4[6]; // @[Niexie.scala 73:40]
  wire  lo_lo_lo = _T_4[7]; // @[Niexie.scala 73:40]
  wire [7:0] _T_15 = {hi_hi_hi,hi_hi_lo,hi_lo_hi,hi_lo_lo,lo_hi_hi,lo_hi_lo,lo_lo_hi,lo_lo_lo}; // @[Cat.scala 30:58]
  wire [7:0] _T_24 = {_T_4[8],_T_4[9],_T_4[10],_T_4[11],_T_4[12],_T_4[13],_T_4[14],_T_4[15]}; // @[Cat.scala 30:58]
  wire [7:0] values_0 = dismiss ? 8'hff : _T_15; // @[Niexie.scala 78:18 Niexie.scala 79:12 Niexie.scala 81:12]
  wire [7:0] values_1 = dismiss ? 8'hff : _T_24; // @[Niexie.scala 78:18 Niexie.scala 79:12 Niexie.scala 81:12]
  wire  _GEN_8 = _dismiss_T | started; // @[Niexie.scala 88:21 Niexie.scala 89:15 Niexie.scala 61:24]
  NiexieDisplay niexieDisplay ( // @[Niexie.scala 98:29]
    .clock(niexieDisplay_clock),
    .reset(niexieDisplay_reset),
    .io_in_values_0(niexieDisplay_io_in_values_0),
    .io_in_values_1(niexieDisplay_io_in_values_1),
    .io_out_ledCx(niexieDisplay_io_out_ledCx),
    .io_out_ledEn(niexieDisplay_io_out_ledEn)
  );
  assign io_out_ledCx = niexieDisplay_io_out_ledCx; // @[Niexie.scala 100:10]
  assign io_out_ledEn = niexieDisplay_io_out_ledEn; // @[Niexie.scala 100:10]
  assign niexieDisplay_clock = clock;
  assign niexieDisplay_reset = reset;
  assign niexieDisplay_io_in_values_0 = dismiss ? 8'hff : values_0; // @[Niexie.scala 99:36]
  assign niexieDisplay_io_in_values_1 = dismiss ? 8'hff : values_1; // @[Niexie.scala 99:36]
  always @(posedge clock) begin
    if (reset) begin // @[Niexie.scala 61:24]
      started <= 1'h0; // @[Niexie.scala 61:24]
    end else if (io_in_button) begin // @[Niexie.scala 84:23]
      started <= 1'h0; // @[Niexie.scala 85:13]
    end else begin
      started <= _GEN_8;
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
  started = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
