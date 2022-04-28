package booth

import chisel3._
import chisel3.internal.naming.chiselName
import chisel3.util._

@chiselName
class Booth(widthInput: Int = 16) extends Module {
  val width = widthInput
  val io = IO(new Bundle {
    val x = Input(UInt(widthInput.W))
    val y = Input(UInt(widthInput.W))
    val busy = Output(Bool())
    val start = Input(Bool())
    val z = Output(UInt((widthInput * 2).W))
  })
  val format = "b"
  val a = RegInit(0.U((width).W))
  val q = RegInit(0.U(width.W))
  val qExtra = RegInit(false.B)
  val cnt = RegInit(0.U(8.W))

  val states = Enum(3)
  val idleState :: runningState :: outputState :: Nil = states
  val state = RegInit(idleState)
  val nextState = Wire(UInt(log2Ceil(states.size).W))
  val stateMatrix = Array(
    idleState -> Mux(io.start, runningState, idleState),
    runningState -> Mux(cnt === (width - 1).U, outputState, runningState),
    outputState -> idleState
  )
  nextState := MuxLookup(state, idleState, stateMatrix)
  state := nextState

  io.busy := false.B
  io.z := 0.U
  val xReg = RegInit(0.U(width.W))
  val minusXReg = RegInit(0.U(width.W))
  val x = io.x
  val minusX = -io.x

  val lastResultReg = RegInit(0.U((width * 2).W))

  def qLast = q(0).asBool

  def pack = VecInit(Seq(qLast, qExtra).reverse).asUInt

  def addShift(addValue: UInt) = {
    val aNext = (a + addValue).asUInt
    val aqNext = (VecInit(Seq(aNext, q).reverse).asUInt.asSInt >> 1.U).asUInt
    val qExtraNext = qLast
    qExtra := qExtraNext
    a := aqNext(width * 2 - 1, width)
    q := aqNext(width - 1, 0)
    printf(s"a: %${format} -> %${format}; aqNext: %${format}; q_-1: %${format} -> %${format}; addValue = %${format}\n",
      a, aNext, aqNext, qExtra, qExtraNext, addValue)
  }

  switch(state) {
    is(idleState) {
      q := io.y
      cnt := 0.U
      xReg := x
      minusXReg := minusX
      io.z := lastResultReg
      a := 0.U
      qExtra := 0.U
    }
    is(runningState) {
      lastResultReg := 0.U
      printf(s"[%${format} state=%${format}] a=%${format}, q=%${format}, qExtra=%${format}, pack=%${format}, x=%${format}, -x=%${format}\n",
        cnt, state, a, q, qExtra, pack, xReg, minusXReg)
      addShift(MuxLookup(pack, 0.U, Array("b01".U -> xReg, "b10".U -> minusXReg)))
      cnt := cnt + 1.U
      io.busy := true.B
    }
    is(outputState) {
      cnt := 0.U
      val result = VecInit(Seq(a, q).reverse).asUInt
      io.z := result
      printf(s"result = %${format}\n", result)
      lastResultReg := result
    }
  }
}
