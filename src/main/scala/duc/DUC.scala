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
class DUC(mode: Int = DUC_125M) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      // 默认书时钟域
      val data = Bool()
      // 用于DAC的快时钟域
      val clockDac = Clock()
      // val resetDac = Bool()
    })
    val out = Output(new Bundle {
      // 快时钟域的DAC数据
      val dac = UInt(8.W)
    })
  })

  val xList = if (mode == DUC_120M) Seq.range(0, 7) else Seq.range(0, 26)
  val yList = VecInit(if (mode == DUC_120M) xList.map(x => (sin(x * 2 * Pi / 6) * 0xEF).toInt.S) else xList.map(x => (sin(x * 8 * Pi / 25) * 0xEF).toInt.S))

  withClock(io.in.clockDac) {
    val cnt = RegInit(0.U(8.W))
    when (cnt === (if (mode == DUC_120M) 6 else 25).U) {
      cnt := 0.U
    } .otherwise {
      cnt := cnt + 1.U
    }
    io.out.dac := (yList(cnt) * Mux(io.in.data, 1.S, -1.S) + 0xEF.S).asTypeOf(UInt(8.W))
  }

}