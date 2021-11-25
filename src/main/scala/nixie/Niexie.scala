package test 
import chisel3._
import chisel3.util._
import chisel3.experimental._


@chiselName
class NiexieDisplay(delay: Int = 5) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val values = Vec(8, UInt(8.W))
      val started = Bool()
    })
    val out = Output(new Bundle {
      val ledCx = UInt(8.W)
      val ledEn = UInt(8.W)
    })
  })
  val cnt = RegInit(0.U(8.W))
  val tim = RegInit(0.U(32.W))

  val mapLookup = Array(
    0x0.U -> "b00111111".U(8.W),
    0x1.U -> "b00000110".U(8.W),
    0x2.U -> "b01011011".U(8.W),
    0x3.U -> "b01001111".U(8.W),
    0x4.U -> "b01100110".U(8.W),
    0x5.U -> "b01101101".U(8.W),
    0x6.U -> "b01111101".U(8.W),
    0x7.U -> "b00000111".U(8.W),
    0x8.U -> "b01111111".U(8.W),
    0x9.U -> "b01100111".U(8.W),
    0xa.U -> "b01110111".U(8.W),
    0xb.U -> "b01111100".U(8.W),
    0xc.U -> "b01011000".U(8.W),
    0xd.U -> "b01011110".U(8.W),
    0xe.U -> "b01111001".U(8.W),
    0xf.U -> "b01110001".U(8.W),
    0x0a.U ->"b00111111".U(8.W),
  )

  val flash = tim === (delay - 1).U

  cnt := Mux(flash, Mux(cnt === 7.U, 0.U, cnt + 1.U), cnt)
  tim := Mux(io.in.started, Mux(flash, 0.U, tim + 1.U), tim)
  io.out.ledEn := ~Mux(io.in.started, 1.U(8.W) << cnt, 0.U(8.W))
  io.out.ledCx := ~Mux(io.in.started, MuxLookup(io.in.values(cnt), ~0xc0.U(8.W), mapLookup), 0.U(8.W))
}

@chiselName
class Niexie(delayFlash: Int = 5, delayUpdate: Int = 40) extends Module {
  val io = IO(new Bundle {
    val in = Input(new Bundle {
      val button = Bool()
    })
    val out = Output(new Bundle {
      val ledCx = UInt(8.W)
      val ledEn = UInt(8.W)
    })
  })

  // val data = 0x10200619.U(32.W)
  val data = 0x10FFFFFF.U(32.W)
  val starting = RegInit(false.B)
  val started = RegInit(false.B)
  val dismiss = io.in.button | (~started)

  val valuesRaw = for {a <- 0 until 8} yield Cat(0.U(4.W), Cat(data.asBools.slice(a * 4, (a + 1) * 4)).asUInt).asUInt
  val valuesBlank = for {a <- 0 until 8} yield 0x0a.U(8.W)

  // val values = VecInit(valuesBlank)
  val values = VecInit(valuesRaw)

  def getNext(pre: UInt) = 
    // Mux(pre === 0x0100.U, 0x0009.U, 
    //   Mux(pre === 0x0000.U, 0x0100.U, pre - 1.U))
    // Mux(pre === 0x0010.U, 0x0900.U, 
    //   Mux(pre === 0x0000.U, 0x0001.U, ((pre >> 8.U) - 1.U) << 8.U))
    pre + 1.U << 8.U
    // pre + 1.U << (8 * 7).U

  def split16(v: UInt) = VecInit(Cat(v.asBools.slice(0, 8)).asUInt, Cat(v.asBools.slice(8, 16)).asUInt)

  val tim = RegInit(0.U(32.W))
  val update = tim === (delayUpdate - 1).U
  val valueLast = Reg(chiselTypeOf(values))
  when (dismiss) {
    values := valuesBlank
  } .otherwise {
    // values := split16(getNext(Cat(valueLast(7).asUInt, valueLast(6).asUInt).asUInt)) ++ valueLast.takeRight(6)
    // values := valueLast(7) +: valueLast.takeRight(7)
    // values := VecInit(valueLast(7), valueLast(0), valueLast(1), valueLast(2), valueLast(3), valueLast(4), valueLast(5), valueLast(6))
    values := RegInit(VecInit(values(7), values(0), values(1), values(2), values(3), values(4), values(5), values(6)))
  }

  when (io.in.button) {
    when (~starting) {
      starting := true.B
    } .otherwise {
      started := false.B
    }
  }

  valueLast := valuesBlank


  when (starting) {
    started := true.B
    when (~started) {
      tim := 0.U
      // valueLast := valuesBlank
    } .otherwise {
      tim := Mux(update, 0.U, tim)
      // valueLast := Mux(update, values, valueLast)
    }
  }

  val niexieDisplay = Module(new NiexieDisplay(delay=delayFlash))
  // niexieDisplay.io.in.values := Mux(dismiss, VecInit(Seq.fill(8)(((-1).S(8.W)).asUInt)), values)
  niexieDisplay.io.in.values := values
  niexieDisplay.io.in.started := started
  io.out <> niexieDisplay.io.out
}