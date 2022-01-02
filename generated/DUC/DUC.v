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
  wire [7:0] _GEN_2 = 3'h1 == cnt[2:0] ? $signed(8'sh6d) : $signed(8'sh0); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [7:0] _GEN_3 = 3'h2 == cnt[2:0] ? $signed(8'sh6d) : $signed(_GEN_2); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [7:0] _GEN_4 = 3'h3 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_3); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [7:0] _GEN_5 = 3'h4 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_4); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [7:0] _GEN_6 = 3'h5 == cnt[2:0] ? $signed(-8'sh6d) : $signed(_GEN_5); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [7:0] _GEN_7 = 3'h6 == cnt[2:0] ? $signed(8'sh0) : $signed(_GEN_6); // @[DUC.scala 46:31 DUC.scala 46:31]
  wire [9:0] _io_out_dac_T_2 = $signed(_GEN_7) * $signed(_io_out_dac_T_1); // @[DUC.scala 46:31]
  wire [9:0] _io_out_dac_T_6 = $signed(_io_out_dac_T_2) + 10'sh7f; // @[DUC.scala 46:78]
  assign io_out_dac = _io_out_dac_T_6[7:0]; // @[DUC.scala 46:78 DUC.scala 46:78]
  always @(posedge io_in_clockDac) begin
    if (reset) begin // @[DUC.scala 40:22]
      cnt <= 8'h0; // @[DUC.scala 40:22]
    end else if (cnt == 8'h6) begin // @[DUC.scala 41:56]
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
