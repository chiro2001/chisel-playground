;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit DUCWrapper : 
  module DUC : 
    input clock : Clock
    input reset : Reset
    output io : {flip in : {data : UInt<1>, sync : UInt<1>}, out : {dac : UInt<8>}}
    
    wire yList : SInt<8>[7] @[DUC.scala 33:22]
    yList[0] <= asSInt(UInt<1>("h00")) @[DUC.scala 33:22]
    yList[1] <= asSInt(UInt<8>("h06d")) @[DUC.scala 33:22]
    yList[2] <= asSInt(UInt<8>("h06d")) @[DUC.scala 33:22]
    yList[3] <= asSInt(UInt<1>("h00")) @[DUC.scala 33:22]
    yList[4] <= asSInt(UInt<8>("h093")) @[DUC.scala 33:22]
    yList[5] <= asSInt(UInt<8>("h093")) @[DUC.scala 33:22]
    yList[6] <= asSInt(UInt<1>("h00")) @[DUC.scala 33:22]
    reg run : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[DUC.scala 35:20]
    reg cnt : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[DUC.scala 36:20]
    io.out.dac <= UInt<1>("h00") @[DUC.scala 37:14]
    when io.in.sync : @[DUC.scala 38:21]
      node _io_out_dac_T = mux(io.in.data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 39:34]
      node _io_out_dac_T_1 = mul(yList[0], _io_out_dac_T) @[DUC.scala 39:29]
      node _io_out_dac_T_2 = add(_io_out_dac_T_1, asSInt(UInt<8>("h07f"))) @[DUC.scala 39:58]
      node _io_out_dac_T_3 = tail(_io_out_dac_T_2, 1) @[DUC.scala 39:58]
      node _io_out_dac_T_4 = asSInt(_io_out_dac_T_3) @[DUC.scala 39:58]
      wire _io_out_dac_WIRE : UInt<8> @[DUC.scala 39:76]
      node _io_out_dac_T_5 = asUInt(_io_out_dac_T_4) @[DUC.scala 39:76]
      _io_out_dac_WIRE <= _io_out_dac_T_5 @[DUC.scala 39:76]
      io.out.dac <= _io_out_dac_WIRE @[DUC.scala 39:16]
      run <= UInt<1>("h01") @[DUC.scala 40:9]
      cnt <= UInt<1>("h00") @[DUC.scala 41:9]
      skip @[DUC.scala 38:21]
    when run : @[DUC.scala 43:14]
      node _T = eq(cnt, UInt<3>("h05")) @[DUC.scala 44:15]
      when _T : @[DUC.scala 44:62]
        cnt <= UInt<1>("h00") @[DUC.scala 45:11]
        run <= io.in.sync @[DUC.scala 46:11]
        skip @[DUC.scala 44:62]
      else : @[DUC.scala 47:18]
        node _cnt_T = add(cnt, UInt<1>("h01")) @[DUC.scala 48:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[DUC.scala 48:18]
        cnt <= _cnt_T_1 @[DUC.scala 48:11]
        skip @[DUC.scala 47:18]
      node _io_out_dac_T_6 = bits(cnt, 2, 0)
      node _io_out_dac_T_7 = mux(io.in.data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 50:36]
      node _io_out_dac_T_8 = mul(yList[_io_out_dac_T_6], _io_out_dac_T_7) @[DUC.scala 50:31]
      node _io_out_dac_T_9 = add(_io_out_dac_T_8, asSInt(UInt<8>("h07f"))) @[DUC.scala 50:60]
      node _io_out_dac_T_10 = tail(_io_out_dac_T_9, 1) @[DUC.scala 50:60]
      node _io_out_dac_T_11 = asSInt(_io_out_dac_T_10) @[DUC.scala 50:60]
      wire _io_out_dac_WIRE_1 : UInt<8> @[DUC.scala 50:78]
      node _io_out_dac_T_12 = asUInt(_io_out_dac_T_11) @[DUC.scala 50:78]
      _io_out_dac_WIRE_1 <= _io_out_dac_T_12 @[DUC.scala 50:78]
      io.out.dac <= _io_out_dac_WIRE_1 @[DUC.scala 50:16]
      skip @[DUC.scala 43:14]
    
  module DUCWrapper : 
    output io : {flip in : {data : UInt<1>, sync : UInt<1>}, out : {dac : UInt<8>}, flip clock : Clock, flip resetN : UInt<1>}
    
    node _T = not(io.resetN) @[DUC.scala 68:31]
    inst module of DUC @[DUC.scala 69:24]
    module.clock <= io.clock
    module.reset <= _T
    module.io.in.sync <= io.in.sync @[DUC.scala 70:18]
    module.io.in.data <= io.in.data @[DUC.scala 70:18]
    io.out.dac <= module.io.out.dac @[DUC.scala 71:19]
    
