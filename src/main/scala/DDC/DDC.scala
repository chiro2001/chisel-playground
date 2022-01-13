package test
import scala.math._
import chisel3._
import chisel3.util._
import chisel3.experimental.chiselName

object DDCMode {
  val DDC_60M = 0;
  val DDC_200M = 1;
}

object DDCOffset {
  val Offset60M = 0;
  val Offset200M = 0;
}

import DDCMode._
import DDCOffset._

@chiselName
class DDC(mode: Int = DDC_200M) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = UInt(8.W)
      val sync = Bool()
    })
    val out = Output(new Bundle {
      val data = Bool()
      val update = Bool()
      val readData = SInt(8.W)
      val value = UInt(16.W)
    })
  })

  def decode(v: UInt, outPort: SInt) = {
    when(v > 0x7f.U) {
      outPort := (v - 0x7f.U).asTypeOf(SInt(outPort.getWidth.W))
    }.otherwise {
      outPort := -(0x7f.U - v).asTypeOf(SInt(outPort.getWidth.W))
    }
  }

  val sampleCount = if (mode == DDC_60M) 3 else 10
  val waveCount = if (mode == DDC_60M) 15 else 50
  val xListRefer = Seq.range(0, sampleCount + 1)
  val yListRefer = VecInit(
    xListRefer.map(x => (sin(x * 2 * Pi / sampleCount) * 0x7f).toInt.S)
  )
  val yListMul = RegInit(VecInit(for {
    a <- 0 to (sampleCount + 1)
  } yield 0.S(16.W)))

  val cnt = RegInit(0.U(16.W))
  // val run = RegInit(false.B)

  def calc(out: Bool) = {
    val ave = yListMul.reduce(_ + _)
    when(ave > 0.S) {
      out := true.B
    }.otherwise {
      out := false.B
    }
  }

  val out = RegInit(false.B)
  val update = RegInit(false.B)

  io.out.value := 0.U
  io.out.readData := 0.S
  io.out.update := update

  def IndexedRefer(index: UInt) =
    (io.out.readData * yListRefer(index).asTypeOf(SInt(8.W)))
      .asTypeOf(SInt(16.W))

  when(io.in.sync) {
    yListMul(0.U) := IndexedRefer(0.U)
    cnt := 1.U
    // run := true.B
  }.otherwise {
    // when (run) {
    // 15 or 50 波/bit
    when(cnt === (waveCount - 1).U) {
      cnt := 0.U
      // 等得 sync_start 脉冲
      // run := io.in.sync
      calc(out)
      update := ~update
    }.otherwise {
      cnt := cnt + 1.U
    }
    decode(io.in.data, io.out.readData)
    val mul = IndexedRefer(cnt)
    yListMul(cnt) := mul
    io.out.value := mul.asTypeOf(UInt(16.W))
    // }
  }

  io.out.data := out
}

@chiselName
class DDCWrapper(mode: Int = DDC_200M) extends RawModule {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = UInt(8.W)
      val sync = Bool()
    })
    val out = Output(new Bundle {
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
