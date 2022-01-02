package test 
import scala.math._
import chisel3._
import chisel3.util._
import chisel3.experimental.chiselName

object DUCMode {
  val DUC_120M = 0;
  val DUC_125M = 1;
}

object DUCOffset {
  val Offset120M = 0;
  val Offset125M = 0;
}

import DUCMode._
import DUCOffset._

@chiselName
class DUC(mode: Int = DUC_120M) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = Bool()
      val sync = Bool()
    })
    val out = Output(new Bundle {
      val dac = UInt(8.W)
    })
  })

  val xList = if (mode == DUC_120M) Seq.range(0, 7) else Seq.range(0, 26)
  val yList = VecInit(if (mode == DUC_120M) xList.map(x => (sin(x * 2 * Pi / 6) * 0x7F).toInt.S) else xList.map(x => (sin(x * 8 * Pi / 25) * 0x7F).toInt.S))

  val run = RegInit(false.B)
  val cnt = RegInit(0.U(8.W))
  io.out.dac := 0.U
  when (io.in.sync) {
    io.out.dac := (yList(0) * Mux(io.in.data, 1.S, -1.S) + 0x7F.S).asTypeOf(UInt(8.W))
    run := true.B
    cnt := 0.U
  }
  when (run) {
    when (cnt === (if (mode == DUC_120M) 6 else 25).U) {
      cnt := 0.U
      run := io.in.sync
    } .otherwise {
      cnt := cnt + 1.U
    }
    io.out.dac := (yList(cnt) * Mux(io.in.data, 1.S, -1.S) + 0x7F.S).asTypeOf(UInt(8.W))
  }
}

@chiselName
class DUCWrapper(mode: Int = DUC_120M) extends RawModule {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = Bool()
      val sync = Bool()
    })
    val out = Output(new Bundle {
      // 快时钟域的DAC数据
      val dac = UInt(8.W)
    })
    val clock = Input(Clock())
    val resetN = Input(Bool())
  })
  withClockAndReset(io.clock, ~io.resetN) {
    val module = Module(new DUC(mode = mode))
    module.io.in <> io.in
    module.io.out <> io.out
  }
}