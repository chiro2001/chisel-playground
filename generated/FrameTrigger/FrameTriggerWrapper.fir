;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit FrameTriggerWrapper : 
  module FrameTrigger : 
    input clock : Clock
    input reset : Reset
    output io : {flip in : {data : UInt<8>, clear : UInt<1>}, out : {trigger : UInt<1>}}
    
    wire _buf_WIRE : UInt<8>[2] @[FrameTrigger.scala 19:28]
    _buf_WIRE[0] <= UInt<8>("h07f") @[FrameTrigger.scala 19:28]
    _buf_WIRE[1] <= UInt<8>("h07f") @[FrameTrigger.scala 19:28]
    reg buf : UInt<8>[2], clock with : (reset => (reset, _buf_WIRE)) @[FrameTrigger.scala 19:20]
    reg cnt : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[FrameTrigger.scala 20:20]
    node _ave_T = lt(buf[0], UInt<7>("h07f")) @[FrameTrigger.scala 25:14]
    node _ave_T_1 = sub(UInt<7>("h07f"), buf[0]) @[FrameTrigger.scala 25:29]
    node _ave_T_2 = tail(_ave_T_1, 1) @[FrameTrigger.scala 25:29]
    node _ave_T_3 = sub(buf[0], UInt<7>("h07f")) @[FrameTrigger.scala 25:36]
    node _ave_T_4 = tail(_ave_T_3, 1) @[FrameTrigger.scala 25:36]
    node _ave_T_5 = mux(_ave_T, _ave_T_2, _ave_T_4) @[FrameTrigger.scala 25:11]
    wire _ave_WIRE : UInt<10> @[FrameTrigger.scala 25:54]
    _ave_WIRE <= _ave_T_5 @[FrameTrigger.scala 25:54]
    node _ave_T_6 = lt(buf[1], UInt<7>("h07f")) @[FrameTrigger.scala 25:14]
    node _ave_T_7 = sub(UInt<7>("h07f"), buf[1]) @[FrameTrigger.scala 25:29]
    node _ave_T_8 = tail(_ave_T_7, 1) @[FrameTrigger.scala 25:29]
    node _ave_T_9 = sub(buf[1], UInt<7>("h07f")) @[FrameTrigger.scala 25:36]
    node _ave_T_10 = tail(_ave_T_9, 1) @[FrameTrigger.scala 25:36]
    node _ave_T_11 = mux(_ave_T_6, _ave_T_8, _ave_T_10) @[FrameTrigger.scala 25:11]
    wire _ave_WIRE_1 : UInt<10> @[FrameTrigger.scala 25:54]
    _ave_WIRE_1 <= _ave_T_11 @[FrameTrigger.scala 25:54]
    node _ave_T_12 = add(_ave_WIRE, _ave_WIRE_1) @[FrameTrigger.scala 27:15]
    node ave = tail(_ave_T_12, 1) @[FrameTrigger.scala 27:15]
    reg run : UInt<1>, clock with : (reset => (reset, UInt<1>("h01"))) @[FrameTrigger.scala 28:20]
    reg triggerDelay : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[FrameTrigger.scala 30:29]
    node _io_out_trigger_T = neq(triggerDelay, UInt<1>("h00")) @[FrameTrigger.scala 31:34]
    io.out.trigger <= _io_out_trigger_T @[FrameTrigger.scala 31:18]
    node _T = or(io.in.clear, run) @[FrameTrigger.scala 32:20]
    when _T : @[FrameTrigger.scala 32:28]
      node _T_1 = neq(cnt, UInt<1>("h00")) @[FrameTrigger.scala 33:14]
      when _T_1 : @[FrameTrigger.scala 33:37]
        node _cnt_T = add(cnt, UInt<1>("h01")) @[FrameTrigger.scala 34:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[FrameTrigger.scala 34:18]
        cnt <= _cnt_T_1 @[FrameTrigger.scala 34:11]
        skip @[FrameTrigger.scala 33:37]
      else : @[FrameTrigger.scala 35:17]
        cnt <= UInt<1>("h00") @[FrameTrigger.scala 36:11]
        skip @[FrameTrigger.scala 35:17]
      node _T_2 = geq(ave, UInt<6>("h02c")) @[FrameTrigger.scala 38:14]
      when _T_2 : @[FrameTrigger.scala 38:28]
        triggerDelay <= UInt<4>("h0f") @[FrameTrigger.scala 39:20]
        run <= UInt<1>("h00") @[FrameTrigger.scala 40:11]
        skip @[FrameTrigger.scala 38:28]
      else : @[FrameTrigger.scala 41:17]
        node _triggerDelay_T = eq(triggerDelay, UInt<1>("h00")) @[FrameTrigger.scala 42:40]
        node _triggerDelay_T_1 = sub(triggerDelay, UInt<1>("h01")) @[FrameTrigger.scala 42:67]
        node _triggerDelay_T_2 = tail(_triggerDelay_T_1, 1) @[FrameTrigger.scala 42:67]
        node _triggerDelay_T_3 = mux(_triggerDelay_T, UInt<1>("h00"), _triggerDelay_T_2) @[FrameTrigger.scala 42:26]
        triggerDelay <= _triggerDelay_T_3 @[FrameTrigger.scala 42:20]
        skip @[FrameTrigger.scala 41:17]
      skip @[FrameTrigger.scala 32:28]
    when io.in.clear : @[FrameTrigger.scala 46:21]
      run <= UInt<1>("h01") @[FrameTrigger.scala 47:9]
      skip @[FrameTrigger.scala 46:21]
    node _T_3 = bits(cnt, 0, 0)
    buf[_T_3] <= io.in.data @[FrameTrigger.scala 49:12]
    
  module FrameTriggerWrapper : 
    output io : {flip in : {data : UInt<8>, clear : UInt<1>}, out : {trigger : UInt<1>}, flip clock : Clock, flip resetN : UInt<1>}
    
    node _T = not(io.resetN) @[FrameTrigger.scala 66:31]
    inst module of FrameTrigger @[FrameTrigger.scala 67:24]
    module.clock <= io.clock
    module.reset <= _T
    module.io.in.clear <= io.in.clear @[FrameTrigger.scala 68:18]
    module.io.in.data <= io.in.data @[FrameTrigger.scala 68:18]
    io.out.trigger <= module.io.out.trigger @[FrameTrigger.scala 69:19]
    
