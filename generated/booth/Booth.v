module Booth(
  input         clock,
  input         reset,
  input  [15:0] io_x,
  input  [15:0] io_y,
  output        io_busy,
  input         io_start,
  output [31:0] io_z
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] a; // @[Booth.scala 16:18]
  reg [15:0] q; // @[Booth.scala 17:18]
  reg  qExtra; // @[Booth.scala 18:23]
  reg [7:0] cnt; // @[Booth.scala 19:20]
  reg [1:0] state; // @[Booth.scala 23:22]
  wire [1:0] _T = io_start ? 2'h1 : 2'h0; // @[Booth.scala 26:21]
  wire  _nextState_T = 2'h0 == state; // @[Mux.scala 81:61]
  wire  _nextState_T_2 = 2'h1 == state; // @[Mux.scala 81:61]
  wire  _nextState_T_4 = 2'h2 == state; // @[Mux.scala 81:61]
  wire [15:0] minusX = 16'h0 - io_x; // @[Booth.scala 36:16]
  wire [1:0] _T_7 = {q[0],qExtra}; // @[Booth.scala 40:50]
  wire  _T_9 = ~reset; // @[Booth.scala 60:13]
  wire [15:0] _T_14 = 2'h1 == _T_7 ? io_x : 16'h0; // @[Mux.scala 81:58]
  wire [15:0] _T_16 = 2'h2 == _T_7 ? minusX : _T_14; // @[Mux.scala 81:58]
  wire [15:0] aNext = a + _T_16; // @[Booth.scala 44:20]
  wire [31:0] _aqNext_T_1 = {aNext,q}; // @[Booth.scala 45:57]
  wire [30:0] _GEN_14 = _aqNext_T_1[31:1]; // @[Booth.scala 45:64]
  wire [31:0] aqNext = {{1{_GEN_14[30]}},_GEN_14}; // @[Booth.scala 45:72]
  wire [7:0] _cnt_T_1 = cnt + 8'h1; // @[Booth.scala 62:18]
  wire [31:0] result = {a,q}; // @[Booth.scala 66:47]
  wire [31:0] _GEN_1 = _nextState_T_4 ? result : 32'h0; // @[Booth.scala 53:17 67:12 34:8]
  wire [31:0] _GEN_7 = _nextState_T_2 ? 32'h0 : _GEN_1; // @[Booth.scala 53:17 34:8]
  wire  _GEN_15 = ~_nextState_T; // @[Booth.scala 60:13]
  wire  _GEN_16 = ~_nextState_T & _nextState_T_2; // @[Booth.scala 60:13]
  assign io_busy = _nextState_T ? 1'h0 : _nextState_T_2; // @[Booth.scala 33:11 53:17]
  assign io_z = _nextState_T ? 32'h0 : _GEN_7; // @[Booth.scala 53:17 34:8]
  always @(posedge clock) begin
    if (reset) begin // @[Booth.scala 16:18]
      a <= 16'h0; // @[Booth.scala 16:18]
    end else if (!(_nextState_T)) begin // @[Booth.scala 53:17]
      if (_nextState_T_2) begin // @[Booth.scala 53:17]
        a <= aqNext[31:16]; // @[Booth.scala 48:7]
      end
    end
    if (reset) begin // @[Booth.scala 17:18]
      q <= 16'h0; // @[Booth.scala 17:18]
    end else if (_nextState_T) begin // @[Booth.scala 53:17]
      q <= io_y; // @[Booth.scala 55:9]
    end else if (_nextState_T_2) begin // @[Booth.scala 53:17]
      q <= aqNext[15:0]; // @[Booth.scala 49:7]
    end
    if (reset) begin // @[Booth.scala 18:23]
      qExtra <= 1'h0; // @[Booth.scala 18:23]
    end else if (!(_nextState_T)) begin // @[Booth.scala 53:17]
      if (_nextState_T_2) begin // @[Booth.scala 53:17]
        qExtra <= q[0]; // @[Booth.scala 47:12]
      end
    end
    if (reset) begin // @[Booth.scala 19:20]
      cnt <= 8'h0; // @[Booth.scala 19:20]
    end else if (_nextState_T) begin // @[Booth.scala 53:17]
      cnt <= 8'h0; // @[Booth.scala 56:11]
    end else if (_nextState_T_2) begin // @[Booth.scala 53:17]
      cnt <= _cnt_T_1; // @[Booth.scala 62:11]
    end else if (_nextState_T_4) begin // @[Booth.scala 53:17]
      cnt <= 8'h0; // @[Booth.scala 65:11]
    end
    if (reset) begin // @[Booth.scala 23:22]
      state <= 2'h0; // @[Booth.scala 23:22]
    end else if (2'h2 == state) begin // @[Mux.scala 81:58]
      state <= 2'h0;
    end else if (2'h1 == state) begin // @[Mux.scala 81:58]
      if (cnt == 8'hf) begin // @[Booth.scala 27:24]
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (2'h0 == state) begin // @[Mux.scala 81:58]
      state <= _T;
    end else begin
      state <= 2'h0;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_nextState_T & _nextState_T_2 & ~reset) begin
          $fwrite(32'h80000002,"[%d state=%d] a=%b, q=%b, qExtra=%b, pack=%b, x=%b, -x=%b\n",cnt,state,a,q,qExtra,_T_7,
            io_x,minusX); // @[Booth.scala 60:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_16 & _T_9) begin
          $fwrite(32'h80000002,"a: %b -> %b; aqNext: %b; q_-1: %b -> %b; addValue = %b\n",a,aNext,aqNext,qExtra,q[0],
            _T_16); // @[Booth.scala 50:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_15 & ~_nextState_T_2 & _nextState_T_4 & _T_9) begin
          $fwrite(32'h80000002,"result = %b\n",result); // @[Booth.scala 68:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  a = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  q = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  qExtra = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
