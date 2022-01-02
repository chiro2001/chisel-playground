module DUC(
  input        clock,
  input        reset,
  input        io_in_data,
  input        io_in_clockDac,
  input        io_in_sync,
  output [7:0] io_out_dac
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  run; // @[DUC.scala 40:22]
  reg [7:0] cnt; // @[DUC.scala 41:22]
  wire [1:0] _io_out_dac_T = io_in_data ? $signed(2'sh1) : $signed(-2'sh1); // @[DUC.scala 44:36]
  wire [9:0] _io_out_dac_T_1 = 8'sh0 * $signed(_io_out_dac_T); // @[DUC.scala 44:31]
  wire [9:0] _io_out_dac_T_5 = $signed(_io_out_dac_T_1) + 10'sh7f; // @[DUC.scala 44:78]
  wire [7:0] _GEN_0 = io_in_sync ? _io_out_dac_T_5[7:0] : 8'h0; // @[DUC.scala 43:23 DUC.scala 44:18 DUC.scala 42:16]
  wire  _GEN_1 = io_in_sync | run; // @[DUC.scala 43:23 DUC.scala 45:11 DUC.scala 40:22]
  wire [7:0] _cnt_T_1 = cnt + 8'h1; // @[DUC.scala 53:20]
  wire [7:0] _GEN_6 = 3'h1 == cnt[2:0] ? $signed(8'sh6d) : $signed(8'sh0); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [7:0] _GEN_7 = 3'h2 == cnt[2:0] ? $signed(8'sh6d) : $signed(_GEN_6); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [7:0] _GEN_8 = 3'h3 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_7); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [7:0] _GEN_9 = 3'h4 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_8); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [7:0] _GEN_10 = 3'h5 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_9); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [7:0] _GEN_11 = 3'h6 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_10); // @[DUC.scala 55:33 DUC.scala 55:33]
  wire [9:0] _io_out_dac_T_8 = $signed(_GEN_11) * $signed(_io_out_dac_T); // @[DUC.scala 55:33]
  wire [9:0] _io_out_dac_T_12 = $signed(_io_out_dac_T_8) + 10'sh7f; // @[DUC.scala 55:80]
  assign io_out_dac = run ? _io_out_dac_T_12[7:0] : _GEN_0; // @[DUC.scala 48:16 DUC.scala 55:18]
  always @(posedge io_in_clockDac) begin
    if (reset) begin // @[DUC.scala 40:22]
      run <= 1'h0; // @[DUC.scala 40:22]
    end else if (run) begin // @[DUC.scala 48:16]
      if (cnt == 8'h6) begin // @[DUC.scala 49:58]
        run <= 1'h0; // @[DUC.scala 51:13]
      end else begin
        run <= _GEN_1;
      end
    end else begin
      run <= _GEN_1;
    end
    if (reset) begin // @[DUC.scala 41:22]
      cnt <= 8'h0; // @[DUC.scala 41:22]
    end else if (run) begin // @[DUC.scala 48:16]
      if (cnt == 8'h6) begin // @[DUC.scala 49:58]
        cnt <= 8'h0; // @[DUC.scala 50:13]
      end else begin
        cnt <= _cnt_T_1; // @[DUC.scala 53:13]
      end
    end else if (io_in_sync) begin // @[DUC.scala 43:23]
      cnt <= 8'h0; // @[DUC.scala 46:11]
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
  run = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
