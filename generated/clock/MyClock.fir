;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit MyClock : 
  module MyClock : 
    input clock : Clock
    input reset : UInt<1>
    output io : {onDone : UInt<1>}
    
    reg clkReg : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[clock.scala 15:25]
    node _clkReg_cntReg_T = eq(clkReg, UInt<3>("h04")) @[clock.scala 16:26]
    node _clkReg_cntReg_T_1 = add(clkReg, UInt<1>("h01")) @[clock.scala 16:47]
    node _clkReg_cntReg_T_2 = tail(_clkReg_cntReg_T_1, 1) @[clock.scala 16:47]
    node _clkReg_cntReg_T_3 = mux(_clkReg_cntReg_T, UInt<1>("h00"), _clkReg_cntReg_T_2) @[clock.scala 16:18]
    clkReg <= _clkReg_cntReg_T_3 @[clock.scala 16:12]
    node _io_onDone_T = eq(clkReg, UInt<1>("h00")) @[clock.scala 22:27]
    node _io_onDone_T_1 = mux(_io_onDone_T, UInt<1>("h00"), UInt<1>("h01")) @[clock.scala 22:19]
    io.onDone <= _io_onDone_T_1 @[clock.scala 22:13]
    
