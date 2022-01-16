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

class DUCOut extends Bundle {
  val dac = UInt(8.W)
  val sync = Bool()
}

@chiselName
class DUC(mode: Int = DUC_120M) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = Bool()
      val sync = Bool()
    })
    val out = Output(new DUCOut)
  })

  val sampleCount = if (mode == DUC_120M) 6 else 25
  val xList = Seq.range(0, sampleCount + 1)
  val yList = VecInit(
    xList.map(x =>
      (sin(x * (if (mode == DUC_120M) 2 else 8) * Pi / 6) * 0x7f).toInt.S
    )
  )
  val data = RegInit(false.B)

  def IndexedData(index: UInt) =
    (yList(index) * Mux(data, 1.S, -1.S) + 0x7f.S).asTypeOf(UInt(8.W))

  val run = RegInit(false.B)
  val cnt = RegInit(0.U(8.W))
  io.out.dac := 0.U + 127.U
  when(io.in.sync) {
    io.out.dac := IndexedData(0.U)
    run := true.B
    cnt := 0.U
    data := io.in.data
  }
  when(run) {
    when(cnt === (sampleCount - 1).U) {
      cnt := 0.U
      run := io.in.sync
    }.otherwise {
      cnt := cnt + 1.U
    }
    io.out.dac := IndexedData(cnt)
  }
  io.out.sync := io.in.sync
}

@chiselName
class DUCWrapper(mode: Int = DUC_120M, cachedLen: Int = 18) extends RawModule {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val data = Bool()
      val sync = Bool()
    })
    val out = Output(new DUCOut)
    val clock = Input(Clock())
    val resetN = Input(Bool())
  })

  withClockAndReset(io.clock, ~io.resetN) {
    val module = Module(new DUC(mode = mode))
    module.io.in <> io.in
    // module.io.out <> now

    val buffer = Reg(Vec(cachedLen + 1, new DUCOut))

    val sIdle :: sCounting :: sOK :: Nil = Enum(3)
    val state = RegInit(sIdle)
    val now = module.io.out
    val cnt = RegInit(0.U(8.W))
    val current = buffer(cachedLen - 1)

    def clearBuffer() = {
      for (i <- 0 to cachedLen) {
        buffer(i).dac := 0.U
        buffer(i).sync := 0.U
      }
    }

    def updateBuffer() = {
      for (i <- 0 to (cachedLen - 1)) {
        buffer(i + 1) := buffer(i)
      }
      buffer(0) := now
    }

    switch(state) {
      is(sIdle) {
        when(io.in.sync) {
          state := sCounting
          cnt := 0.U
        }
        clearBuffer()
      }
      is(sCounting) {
        when(cnt =/= cachedLen.U) {
          when(io.in.data =/= 0.U) {
            state := sOK
          }.otherwise {
            cnt := cnt + 1.U
          }
        }.otherwise {
          state := Mux(io.in.sync, sOK, sIdle)
        }
        updateBuffer()
      }
      is(sOK) {
        when(current.sync === 0.U) {
          state := sIdle
        }
        updateBuffer()
      }
    }

    io.out.dac := 0.U
    io.out.sync := false.B
    when(state === sOK) {
      io.out := current
    }
  }
}
