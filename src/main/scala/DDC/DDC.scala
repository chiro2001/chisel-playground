package test 
import scala.math._
import chisel3._
import chisel3.util._
import chisel3.experimental.chiselName

object DDCMode {
  val DDC_60M = 0;
  val DDC_65M = 1;
}

object DDCOffset {
  val Offset60M = 0;
  val Offset65M = 0;
}

import DDCMode._
import DDCOffset._

@chiselName
class DDC(mode: Int = DDC_60M) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      // 在快时钟域（120M/125M）
      val data = UInt(8.W)
      val sync = Bool()
    })
    val out = Output(new Bundle {
      // 慢时钟域（直接分频）
      val data = Bool()
      val update = Bool()
      val readData = SInt(8.W)
      val value = UInt(16.W)
    })
  })

  def decode(v: UInt, outPort: SInt) = {
    when (v > 0x7F.U) {
      outPort := (v - 0x7F.U).asTypeOf(SInt(outPort.getWidth.W))
    } .otherwise {
      outPort := -(0x7F.U - v).asTypeOf(SInt(outPort.getWidth.W))
    }
  }

  val xListRefer = if (mode == DDC_60M) Seq.range(0, 3) else Seq.range(0, 26)
  val yListRefer = VecInit(if (mode == DDC_60M) xListRefer.map(x => (sin(x * 2 * Pi / 3) * 0x7F).toInt.S) else xListRefer.map(x => (sin(x * 8 * Pi / 25) * 0x7F).toInt.S))

  val yListMul = RegInit(VecInit(for {a <- 0 to 3} yield 0.S(16.W)))

  val cnt = RegInit(0.U(8.W))
  val run = RegInit(false.B)

  // For 60M Only
  def calc(out: Bool) = {
    val ave = yListMul.reduce(_ + _)
    when (ave > 0.S) {
      out := true.B
    } .otherwise {
      out := false.B
    }
  }

  val out = RegInit(false.B)
  val update = RegInit(false.B)

  io.out.value := 0.U
  io.out.readData := 0.S
  io.out.update := update

  when (io.in.sync) {
    yListMul(0.U) := (io.out.readData * yListRefer(0).asTypeOf(SInt(8.W))).asTypeOf(SInt(16.W));
    cnt := 1.U
    run := true.B
  } .otherwise {
    when (run) {
      // 15波/bit
      when (cnt === 14.U) {
        cnt := 0.U
        run := io.in.sync
        calc(out)
        update := ~update
      } .otherwise {
        cnt := cnt + 1.U
      }
      decode(io.in.data, io.out.readData)
      val mul = (io.out.readData * yListRefer(cnt).asTypeOf(SInt(8.W))).asTypeOf(SInt(16.W))
      yListMul(cnt) := mul
      io.out.value := mul.asTypeOf(UInt(16.W))
    }
  }

  io.out.data := out
}

@chiselName
class DDCWrapper(mode: Int = DDC_60M) extends RawModule {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      // 在快时钟域（120M/125M）
      val data = UInt(8.W)
      val sync = Bool()
    })
    val out = Output(new Bundle {
      // 慢时钟域（直接分频）
      val data = Bool()
      val update = Bool()
      val readData = SInt(8.W)
      val value = UInt(16.W)
    })
    val clock = Input(Clock())
    val resetN = Input(Bool())
  })
  withClockAndReset(io.clock, ~io.resetN) {
    val module = Module(new DDC(mode = mode))
    module.io.in <> io.in
    module.io.out <> io.out
  }
}