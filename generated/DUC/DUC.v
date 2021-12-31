module DUC(
  input        clock,
  input        reset,
  input        io_in_data,
  input        io_in_clockDac,
  output [7:0] io_out_dac
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] cnt; // @[DUC.scala 40:22]
  wire [7:0] _cnt_T_1 = cnt + 8'h1; // @[DUC.scala 44:18]
  wire [1:0] _io_out_dac_T_1 = io_in_data ? $signed(2'sh1) : $signed(-2'sh1); // @[DUC.scala 46:36]
  wire [8:0] _GEN_2 = 5'h1 == cnt[4:0] ? $signed(9'shc9) : $signed(9'sh0); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_3 = 5'h2 == cnt[4:0] ? $signed(9'shd8) : $signed(_GEN_2); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_4 = 5'h3 == cnt[4:0] ? $signed(9'sh1d) : $signed(_GEN_3); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_5 = 5'h4 == cnt[4:0] ? $signed(-9'shb8) : $signed(_GEN_4); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_6 = 5'h5 == cnt[4:0] ? $signed(-9'she3) : $signed(_GEN_5); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_7 = 5'h6 == cnt[4:0] ? $signed(-9'sh3b) : $signed(_GEN_6); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_8 = 5'h7 == cnt[4:0] ? $signed(9'sha3) : $signed(_GEN_7); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_9 = 5'h8 == cnt[4:0] ? $signed(9'shea) : $signed(_GEN_8); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_10 = 5'h9 == cnt[4:0] ? $signed(9'sh57) : $signed(_GEN_9); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_11 = 5'ha == cnt[4:0] ? $signed(-9'sh8c) : $signed(_GEN_10); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_12 = 5'hb == cnt[4:0] ? $signed(-9'shee) : $signed(_GEN_11); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_13 = 5'hc == cnt[4:0] ? $signed(-9'sh73) : $signed(_GEN_12); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_14 = 5'hd == cnt[4:0] ? $signed(9'sh73) : $signed(_GEN_13); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_15 = 5'he == cnt[4:0] ? $signed(9'shee) : $signed(_GEN_14); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_16 = 5'hf == cnt[4:0] ? $signed(9'sh8c) : $signed(_GEN_15); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_17 = 5'h10 == cnt[4:0] ? $signed(-9'sh57) : $signed(_GEN_16); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_18 = 5'h11 == cnt[4:0] ? $signed(-9'shea) : $signed(_GEN_17); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_19 = 5'h12 == cnt[4:0] ? $signed(-9'sha3) : $signed(_GEN_18); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_20 = 5'h13 == cnt[4:0] ? $signed(9'sh3b) : $signed(_GEN_19); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_21 = 5'h14 == cnt[4:0] ? $signed(9'she3) : $signed(_GEN_20); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_22 = 5'h15 == cnt[4:0] ? $signed(9'shb8) : $signed(_GEN_21); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_23 = 5'h16 == cnt[4:0] ? $signed(-9'sh1d) : $signed(_GEN_22); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_24 = 5'h17 == cnt[4:0] ? $signed(-9'shd8) : $signed(_GEN_23); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_25 = 5'h18 == cnt[4:0] ? $signed(-9'shc9) : $signed(_GEN_24); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [8:0] _GEN_26 = 5'h19 == cnt[4:0] ? $signed(9'sh0) : $signed(_GEN_25); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [10:0] _io_out_dac_T_2 = $signed(_GEN_26) * $signed(_io_out_dac_T_1); // @[DUC.scala 46:31]
  wire [10:0] _io_out_dac_T_6 = $signed(_io_out_dac_T_2) + 11'shef; // @[DUC.scala 46:78]
  assign io_out_dac = _io_out_dac_T_6[7:0]; // @[DUC.scala 46:78 DUC.scala 46:78]
  always @(posedge io_in_clockDac) begin
    if (reset) begin // @[DUC.scala 40:22]
      cnt <= 8'h0; // @[DUC.scala 40:22]
    end else if (cnt == 8'h19) begin // @[DUC.scala 41:56]
      cnt <= 8'h0; // @[DUC.scala 42:11]
    end else begin
      cnt <= _cnt_T_1; // @[DUC.scala 44:11]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
