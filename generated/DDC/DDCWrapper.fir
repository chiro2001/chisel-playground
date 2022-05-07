circuit DDCWrapper :
  module DDC :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { data : UInt<8>, sync : UInt<1>}, out : { data : UInt<1>, update : UInt<1>, readData : SInt<8>, ave : SInt<8>}}

    wire yListRefer : SInt<8>[4] @[DDC.scala 44:27]
    yListRefer[0] <= asSInt(UInt<1>("h0")) @[DDC.scala 44:27]
    yListRefer[1] <= asSInt(UInt<8>("h6d")) @[DDC.scala 44:27]
    yListRefer[2] <= asSInt(UInt<8>("h93")) @[DDC.scala 44:27]
    yListRefer[3] <= asSInt(UInt<1>("h0")) @[DDC.scala 44:27]
    wire _yListMul_WIRE : SInt<16>[5] @[DDC.scala 47:33]
    _yListMul_WIRE[0] <= asSInt(UInt<16>("h0")) @[DDC.scala 47:33]
    _yListMul_WIRE[1] <= asSInt(UInt<16>("h0")) @[DDC.scala 47:33]
    _yListMul_WIRE[2] <= asSInt(UInt<16>("h0")) @[DDC.scala 47:33]
    _yListMul_WIRE[3] <= asSInt(UInt<16>("h0")) @[DDC.scala 47:33]
    _yListMul_WIRE[4] <= asSInt(UInt<16>("h0")) @[DDC.scala 47:33]
    reg yListMul : SInt<16>[5], clock with :
      reset => (reset, _yListMul_WIRE) @[DDC.scala 47:25]
    reg cnt : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[DDC.scala 51:20]
    node _ave_T = add(yListMul[0], yListMul[1]) @[DDC.scala 53:31]
    node _ave_T_1 = tail(_ave_T, 1) @[DDC.scala 53:31]
    node _ave_T_2 = asSInt(_ave_T_1) @[DDC.scala 53:31]
    node _ave_T_3 = add(_ave_T_2, yListMul[2]) @[DDC.scala 53:31]
    node _ave_T_4 = tail(_ave_T_3, 1) @[DDC.scala 53:31]
    node _ave_T_5 = asSInt(_ave_T_4) @[DDC.scala 53:31]
    node _ave_T_6 = add(_ave_T_5, yListMul[3]) @[DDC.scala 53:31]
    node _ave_T_7 = tail(_ave_T_6, 1) @[DDC.scala 53:31]
    node _ave_T_8 = asSInt(_ave_T_7) @[DDC.scala 53:31]
    node _ave_T_9 = add(_ave_T_8, yListMul[4]) @[DDC.scala 53:31]
    node _ave_T_10 = tail(_ave_T_9, 1) @[DDC.scala 53:31]
    node ave = asSInt(_ave_T_10) @[DDC.scala 53:31]
    io.out.ave <= ave @[DDC.scala 55:14]
    reg out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DDC.scala 65:20]
    reg update : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DDC.scala 66:23]
    io.out.readData <= asSInt(UInt<1>("h0")) @[DDC.scala 69:19]
    io.out.update <= update @[DDC.scala 70:17]
    when io.in.sync : @[DDC.scala 76:20]
      wire _yListMul_0_WIRE : SInt<8> @[DDC.scala 73:50]
      node _yListMul_0_T = asUInt(yListRefer[UInt<1>("h0")]) @[DDC.scala 73:50]
      node _yListMul_0_T_1 = asSInt(_yListMul_0_T) @[DDC.scala 73:50]
      _yListMul_0_WIRE <= _yListMul_0_T_1 @[DDC.scala 73:50]
      node _yListMul_0_T_2 = mul(io.out.readData, _yListMul_0_WIRE) @[DDC.scala 73:22]
      wire _yListMul_0_WIRE_1 : SInt<16> @[DDC.scala 74:16]
      node _yListMul_0_T_3 = asUInt(_yListMul_0_T_2) @[DDC.scala 74:16]
      node _yListMul_0_T_4 = asSInt(_yListMul_0_T_3) @[DDC.scala 74:16]
      _yListMul_0_WIRE_1 <= _yListMul_0_T_4 @[DDC.scala 74:16]
      yListMul[UInt<1>("h0")] <= _yListMul_0_WIRE_1 @[DDC.scala 77:19]
      cnt <= UInt<1>("h1") @[DDC.scala 78:9]
    else :
      node _T = eq(cnt, UInt<4>("he")) @[DDC.scala 83:14]
      when _T : @[DDC.scala 83:37]
        cnt <= UInt<1>("h0") @[DDC.scala 84:11]
        node _T_1 = gt(ave, asSInt(UInt<1>("h0"))) @[DDC.scala 58:14]
        when _T_1 : @[DDC.scala 58:21]
          out <= UInt<1>("h1") @[DDC.scala 59:11]
        else :
          out <= UInt<1>("h0") @[DDC.scala 61:11]
        node _update_T = not(update) @[DDC.scala 88:17]
        update <= _update_T @[DDC.scala 88:14]
      else :
        node _cnt_T = add(cnt, UInt<1>("h1")) @[DDC.scala 90:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[DDC.scala 90:18]
        cnt <= _cnt_T_1 @[DDC.scala 90:11]
      node _T_2 = gt(io.in.data, UInt<7>("h7f")) @[DDC.scala 34:12]
      when _T_2 : @[DDC.scala 34:22]
        node _io_out_readData_T = sub(io.in.data, UInt<7>("h7f")) @[DDC.scala 35:21]
        node _io_out_readData_T_1 = tail(_io_out_readData_T, 1) @[DDC.scala 35:21]
        wire _io_out_readData_WIRE : SInt<8> @[DDC.scala 35:39]
        node _io_out_readData_T_2 = asSInt(_io_out_readData_T_1) @[DDC.scala 35:39]
        _io_out_readData_WIRE <= _io_out_readData_T_2 @[DDC.scala 35:39]
        io.out.readData <= _io_out_readData_WIRE @[DDC.scala 35:15]
      else :
        node _io_out_readData_T_3 = sub(UInt<7>("h7f"), io.in.data) @[DDC.scala 37:27]
        node _io_out_readData_T_4 = tail(_io_out_readData_T_3, 1) @[DDC.scala 37:27]
        wire _io_out_readData_WIRE_1 : SInt<8> @[DDC.scala 37:40]
        node _io_out_readData_T_5 = asSInt(_io_out_readData_T_4) @[DDC.scala 37:40]
        _io_out_readData_WIRE_1 <= _io_out_readData_T_5 @[DDC.scala 37:40]
        node _io_out_readData_T_6 = sub(asSInt(UInt<1>("h0")), _io_out_readData_WIRE_1) @[DDC.scala 37:18]
        node _io_out_readData_T_7 = tail(_io_out_readData_T_6, 1) @[DDC.scala 37:18]
        node _io_out_readData_T_8 = asSInt(_io_out_readData_T_7) @[DDC.scala 37:18]
        io.out.readData <= _io_out_readData_T_8 @[DDC.scala 37:15]
      node _mul_T = bits(cnt, 1, 0)
      wire _mul_WIRE : SInt<8> @[DDC.scala 73:50]
      node _mul_T_1 = asUInt(yListRefer[_mul_T]) @[DDC.scala 73:50]
      node _mul_T_2 = asSInt(_mul_T_1) @[DDC.scala 73:50]
      _mul_WIRE <= _mul_T_2 @[DDC.scala 73:50]
      node _mul_T_3 = mul(io.out.readData, _mul_WIRE) @[DDC.scala 73:22]
      wire mul : SInt<16> @[DDC.scala 74:16]
      node _mul_T_4 = asUInt(_mul_T_3) @[DDC.scala 74:16]
      node _mul_T_5 = asSInt(_mul_T_4) @[DDC.scala 74:16]
      mul <= _mul_T_5 @[DDC.scala 74:16]
      node _T_3 = bits(cnt, 2, 0)
      yListMul[_T_3] <= mul @[DDC.scala 94:19]
    io.out.data <= out @[DDC.scala 99:15]

  module DDCWrapper :
    output io : { flip in : { data : UInt<8>, sync : UInt<1>}, out : { data : UInt<1>, update : UInt<1>, readData : SInt<8>, ave : SInt<8>}, flip clock : Clock, flip resetN : UInt<1>}

    node _T = not(io.resetN) @[DDC.scala 117:31]
    inst module of DDC @[DDC.scala 118:24]
    module.clock <= io.clock
    module.reset <= _T
    module.io.in <= io.in @[DDC.scala 119:18]
    io.out <= module.io.out @[DDC.scala 120:19]

