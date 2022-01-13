;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit DUCWrapper : 
  module DUC : 
    input clock : Clock
    input reset : Reset
    output io : {flip in : {data : UInt<1>, sync : UInt<1>}, out : {dac : UInt<8>}}
    
    wire yList : SInt<8>[7] @[DUC.scala 34:22]
    yList[0] <= asSInt(UInt<1>("h00")) @[DUC.scala 34:22]
    yList[1] <= asSInt(UInt<8>("h06d")) @[DUC.scala 34:22]
    yList[2] <= asSInt(UInt<8>("h06d")) @[DUC.scala 34:22]
    yList[3] <= asSInt(UInt<1>("h00")) @[DUC.scala 34:22]
    yList[4] <= asSInt(UInt<8>("h093")) @[DUC.scala 34:22]
    yList[5] <= asSInt(UInt<8>("h093")) @[DUC.scala 34:22]
    yList[6] <= asSInt(UInt<1>("h00")) @[DUC.scala 34:22]
    reg run : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[DUC.scala 37:20]
    reg cnt : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[DUC.scala 38:20]
    io.out.dac <= UInt<1>("h00") @[DUC.scala 39:14]
    when io.in.sync : @[DUC.scala 40:21]
      node _io_out_dac_T = mux(io.in.data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 35:53]
      node _io_out_dac_T_1 = mul(yList[UInt<1>("h00")], _io_out_dac_T) @[DUC.scala 35:48]
      node _io_out_dac_T_2 = add(_io_out_dac_T_1, asSInt(UInt<8>("h07f"))) @[DUC.scala 35:77]
      node _io_out_dac_T_3 = tail(_io_out_dac_T_2, 1) @[DUC.scala 35:77]
      node _io_out_dac_T_4 = asSInt(_io_out_dac_T_3) @[DUC.scala 35:77]
      wire _io_out_dac_WIRE : UInt<8> @[DUC.scala 35:95]
      node _io_out_dac_T_5 = asUInt(_io_out_dac_T_4) @[DUC.scala 35:95]
      _io_out_dac_WIRE <= _io_out_dac_T_5 @[DUC.scala 35:95]
      io.out.dac <= _io_out_dac_WIRE @[DUC.scala 41:16]
      run <= UInt<1>("h01") @[DUC.scala 42:9]
      cnt <= UInt<1>("h00") @[DUC.scala 43:9]
      skip @[DUC.scala 40:21]
    when run : @[DUC.scala 45:14]
      node _T = eq(cnt, UInt<3>("h05")) @[DUC.scala 46:15]
      when _T : @[DUC.scala 46:40]
        cnt <= UInt<1>("h00") @[DUC.scala 47:11]
        run <= io.in.sync @[DUC.scala 48:11]
        skip @[DUC.scala 46:40]
      else : @[DUC.scala 49:18]
        node _cnt_T = add(cnt, UInt<1>("h01")) @[DUC.scala 50:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[DUC.scala 50:18]
        cnt <= _cnt_T_1 @[DUC.scala 50:11]
        skip @[DUC.scala 49:18]
      node _io_out_dac_T_6 = bits(cnt, 2, 0)
      node _io_out_dac_T_7 = mux(io.in.data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 35:53]
      node _io_out_dac_T_8 = mul(yList[_io_out_dac_T_6], _io_out_dac_T_7) @[DUC.scala 35:48]
      node _io_out_dac_T_9 = add(_io_out_dac_T_8, asSInt(UInt<8>("h07f"))) @[DUC.scala 35:77]
      node _io_out_dac_T_10 = tail(_io_out_dac_T_9, 1) @[DUC.scala 35:77]
      node _io_out_dac_T_11 = asSInt(_io_out_dac_T_10) @[DUC.scala 35:77]
      wire _io_out_dac_WIRE_1 : UInt<8> @[DUC.scala 35:95]
      node _io_out_dac_T_12 = asUInt(_io_out_dac_T_11) @[DUC.scala 35:95]
      _io_out_dac_WIRE_1 <= _io_out_dac_T_12 @[DUC.scala 35:95]
      io.out.dac <= _io_out_dac_WIRE_1 @[DUC.scala 52:16]
      skip @[DUC.scala 45:14]
    
  module DUCWrapper : 
    output io : {flip in : {data : UInt<1>, sync : UInt<1>}, out : {dac : UInt<8>}, flip clock : Clock, flip resetN : UInt<1>}
    
    node _T = not(io.resetN) @[DUC.scala 70:31]
    inst module of DUC @[DUC.scala 71:24]
    module.clock <= io.clock
    module.reset <= _T
    module.io.in.sync <= io.in.sync @[DUC.scala 72:18]
    module.io.in.data <= io.in.data @[DUC.scala 72:18]
    io.out.dac <= module.io.out.dac @[DUC.scala 73:19]
    
