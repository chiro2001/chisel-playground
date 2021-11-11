;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit AND : 
  module AND : 
    output io : {flip a : UInt<1>, flip b : UInt<1>, c : UInt<1>}
    
    node _io_c_T = and(io.a, io.b) @[AND.scala 14:16]
    io.c <= _io_c_T @[AND.scala 14:8]
    
