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
    reg data : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[DUC.scala 35:21]
    reg run : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[DUC.scala 39:20]
    reg cnt : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[DUC.scala 40:20]
    node _io_out_dac_T = add(UInt<1>("h00"), UInt<7>("h07f")) @[DUC.scala 41:21]
    node _io_out_dac_T_1 = tail(_io_out_dac_T, 1) @[DUC.scala 41:21]
    io.out.dac <= _io_out_dac_T_1 @[DUC.scala 41:14]
    when io.in.sync : @[DUC.scala 42:21]
      node _io_out_dac_T_2 = mux(data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 37:53]
      node _io_out_dac_T_3 = mul(yList[UInt<1>("h00")], _io_out_dac_T_2) @[DUC.scala 37:48]
      node _io_out_dac_T_4 = add(_io_out_dac_T_3, asSInt(UInt<8>("h07f"))) @[DUC.scala 37:71]
      node _io_out_dac_T_5 = tail(_io_out_dac_T_4, 1) @[DUC.scala 37:71]
      node _io_out_dac_T_6 = asSInt(_io_out_dac_T_5) @[DUC.scala 37:71]
      wire _io_out_dac_WIRE : UInt<8> @[DUC.scala 37:89]
      node _io_out_dac_T_7 = asUInt(_io_out_dac_T_6) @[DUC.scala 37:89]
      _io_out_dac_WIRE <= _io_out_dac_T_7 @[DUC.scala 37:89]
      io.out.dac <= _io_out_dac_WIRE @[DUC.scala 43:16]
      run <= UInt<1>("h01") @[DUC.scala 44:9]
      cnt <= UInt<1>("h00") @[DUC.scala 45:9]
      data <= io.in.data @[DUC.scala 46:10]
      skip @[DUC.scala 42:21]
    when run : @[DUC.scala 48:14]
      node _T = eq(cnt, UInt<3>("h05")) @[DUC.scala 49:15]
      when _T : @[DUC.scala 49:40]
        cnt <= UInt<1>("h00") @[DUC.scala 50:11]
        run <= io.in.sync @[DUC.scala 51:11]
        skip @[DUC.scala 49:40]
      else : @[DUC.scala 52:18]
        node _cnt_T = add(cnt, UInt<1>("h01")) @[DUC.scala 53:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[DUC.scala 53:18]
        cnt <= _cnt_T_1 @[DUC.scala 53:11]
        skip @[DUC.scala 52:18]
      node _io_out_dac_T_8 = bits(cnt, 2, 0)
      node _io_out_dac_T_9 = mux(data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 37:53]
      node _io_out_dac_T_10 = mul(yList[_io_out_dac_T_8], _io_out_dac_T_9) @[DUC.scala 37:48]
      node _io_out_dac_T_11 = add(_io_out_dac_T_10, asSInt(UInt<8>("h07f"))) @[DUC.scala 37:71]
      node _io_out_dac_T_12 = tail(_io_out_dac_T_11, 1) @[DUC.scala 37:71]
      node _io_out_dac_T_13 = asSInt(_io_out_dac_T_12) @[DUC.scala 37:71]
      wire _io_out_dac_WIRE_1 : UInt<8> @[DUC.scala 37:89]
      node _io_out_dac_T_14 = asUInt(_io_out_dac_T_13) @[DUC.scala 37:89]
      _io_out_dac_WIRE_1 <= _io_out_dac_T_14 @[DUC.scala 37:89]
      io.out.dac <= _io_out_dac_WIRE_1 @[DUC.scala 55:16]
      skip @[DUC.scala 48:14]
    
  module DUCWrapper : 
    output io : {flip in : {data : UInt<1>, sync : UInt<1>}, out : {dac : UInt<8>}, flip clock : Clock, flip resetN : UInt<1>}
    
    node _T = not(io.resetN) @[DUC.scala 73:31]
    inst module of DUC @[DUC.scala 74:24]
    module.clock <= io.clock
    module.reset <= _T
    module.io.in.sync <= io.in.sync @[DUC.scala 75:18]
    module.io.in.data <= io.in.data @[DUC.scala 75:18]
    io.out.dac <= module.io.out.dac @[DUC.scala 76:19]
    
