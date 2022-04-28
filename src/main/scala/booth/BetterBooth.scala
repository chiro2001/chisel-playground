package booth

import chisel3._
import chisel3.internal.naming.chiselName
import chisel3.util._

@chiselName
class BetterBooth(widthInput: Int = 16) extends BoothPort {
  val width = widthInput
  val format = "b"
  val a = RegInit(0.U(width.W))
  val q = RegInit(0.U(width.W))
  val qExtra = RegInit(false.B)
  val cnt = RegInit(0.U(8.W))

  val states = Enum(3)
  val idleState :: runningState :: outputState :: Nil = states
  val state = RegInit(idleState)
  val nextState = Wire(UInt(log2Ceil(states.size).W))
  val stateMatrix = Array(
    idleState -> Mux(io.start, runningState, idleState),
    runningState -> Mux(cnt === (width / 2 - 1).U, outputState, runningState),
    outputState -> idleState
  )
  nextState := MuxLookup(state, idleState, stateMatrix)
  state := nextState

  io.busy := false.B
  io.z := 0.U
  val xReg = RegInit(0.U((width * 2).W))
  val x = io.x

  val lastResultReg = RegInit(0.U((width * 2).W))

  def qLast = q(1, 0)

  def pack = VecInit(qLast.asBools ++ qExtra.asBools).asUInt

  def addShift(addValue: UInt) = {
    val aNext = (a + addValue).asUInt
    val aqNext = (VecInit(Seq(aNext, q).reverse).asUInt.asSInt >> 2.U).asUInt
    val qExtraNext = qLast(0)
    qExtra := qExtraNext
    a := aqNext(width * 2 - 1, width)
    q := aqNext(width - 1, 0)
    printf(s"a: %$format -> %$format; aqNext: %$format; q_-1: %$format -> %$format; addValue = %$format\n",
      a, aNext, aqNext, qExtra, qExtraNext, addValue)
  }

  def get2XReg = (xReg << 1.U).asUInt

  switch(state) {
    is(idleState) {
      q := io.y
      cnt := 0.U
      xReg := x.asTypeOf(UInt(xReg.getWidth.W))
      io.z := lastResultReg
      a := 0.U
      qExtra := 0.U
    }
    is(runningState) {
      println(f"pack size = ${pack.getWidth}, qLast size = ${qLast.getWidth}, qExtra size = ${qExtra.getWidth}")
      lastResultReg := 0.U
      printf(s"[%$format state=%$format] a=%$format, q=%$format, qExtra=%$format, pack=%$format, x=%$format, -x=%$format\n",
        cnt, state, a, q, qExtra, pack, xReg, -xReg)
      addShift(MuxLookup(pack, 0.U, Array(
        "b001".U -> xReg,
        "b010".U -> xReg,
        "b011".U -> get2XReg,
        "b100".U -> -get2XReg,
        "b101".U -> -xReg,
        "b110".U -> -xReg,
      )))
      cnt := cnt + 1.U
      io.busy := true.B
    }
    is(outputState) {
      cnt := 0.U
      val result = VecInit(Seq(a, q).reverse).asUInt
      io.z := result
      printf(s"result = %$format\n", result)
      lastResultReg := result
    }
  }
}
