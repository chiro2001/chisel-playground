;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit DUC : 
  module DUC : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip in : {data : UInt<1>, clockDac : Clock}, out : {dac : UInt<8>}}
    
    wire yList : SInt<8>[7] @[DUC.scala 37:22]
    yList[0] <= asSInt(UInt<1>("h00")) @[DUC.scala 37:22]
    yList[1] <= asSInt(UInt<8>("h06d")) @[DUC.scala 37:22]
    yList[2] <= asSInt(UInt<8>("h06d")) @[DUC.scala 37:22]
    yList[3] <= asSInt(UInt<1>("h00")) @[DUC.scala 37:22]
    yList[4] <= asSInt(UInt<8>("h093")) @[DUC.scala 37:22]
    yList[5] <= asSInt(UInt<8>("h093")) @[DUC.scala 37:22]
    yList[6] <= asSInt(UInt<1>("h00")) @[DUC.scala 37:22]
    reg cnt : UInt<8>, io.in.clockDac with : (reset => (reset, UInt<8>("h00"))) @[DUC.scala 40:22]
    node _T = eq(cnt, UInt<3>("h06")) @[DUC.scala 41:15]
    when _T : @[DUC.scala 41:56]
      cnt <= UInt<1>("h00") @[DUC.scala 42:11]
      skip @[DUC.scala 41:56]
    else : @[DUC.scala 43:18]
      node _cnt_T = add(cnt, UInt<1>("h01")) @[DUC.scala 44:18]
      node _cnt_T_1 = tail(_cnt_T, 1) @[DUC.scala 44:18]
      cnt <= _cnt_T_1 @[DUC.scala 44:11]
      skip @[DUC.scala 43:18]
    node _io_out_dac_T = bits(cnt, 2, 0)
    node _io_out_dac_T_1 = mux(io.in.data, asSInt(UInt<2>("h01")), asSInt(UInt<1>("h01"))) @[DUC.scala 46:36]
    node _io_out_dac_T_2 = mul(yList[_io_out_dac_T], _io_out_dac_T_1) @[DUC.scala 46:31]
    node _io_out_dac_T_3 = add(_io_out_dac_T_2, asSInt(UInt<8>("h07f"))) @[DUC.scala 46:60]
    node _io_out_dac_T_4 = tail(_io_out_dac_T_3, 1) @[DUC.scala 46:60]
    node _io_out_dac_T_5 = asSInt(_io_out_dac_T_4) @[DUC.scala 46:60]
    wire _io_out_dac_WIRE : UInt<8> @[DUC.scala 46:78]
    node _io_out_dac_T_6 = asUInt(_io_out_dac_T_5) @[DUC.scala 46:78]
    _io_out_dac_WIRE <= _io_out_dac_T_6 @[DUC.scala 46:78]
    io.out.dac <= _io_out_dac_WIRE @[DUC.scala 46:16]
    
