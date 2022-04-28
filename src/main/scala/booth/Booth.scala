package booth

import chisel3._
import chisel3.internal.naming.chiselName
import chisel3.util._

@chiselName
class Booth(widthInput: Int = 16) extends Module {
  val io = IO(new Bundle {
    val x = Input(UInt(widthInput.W))
    val y = Input(UInt(widthInput.W))
    val busy = Output(Bool())
    val start = Input(Bool())
    val z = Output(UInt((widthInput * 2).W))
  })
  val a = RegInit(0.U(widthInput.W))
  val q = RegInit(0.U(widthInput.W))
  val qExtra = RegInit(false.B)
  val cnt = RegInit(0.U(8.W))

  val states = Enum(3)
  val idleState :: runningState :: outputState :: Nil = states
  val state = RegInit(idleState)
  val nextState = Wire(UInt(log2Ceil(states.size).W))
  val stateMatrix = Array(
    idleState -> Mux(io.start, runningState, idleState),
    runningState -> Mux(cnt === (widthInput - 1).U, outputState, runningState),
    outputState -> idleState
  )
  nextState := MuxLookup(state, idleState, stateMatrix)
  state := nextState

  io.busy := false.B
  io.z := 0.U
  val xReg = RegInit(0.U(widthInput.W))
  val minusXReg = RegInit(0.U(widthInput.W))
  val x = io.x
  val minusX = -io.x

  val lastResultReg = RegInit(0.U((widthInput * 2).W))

  def qLast = q(0).asBool

  def pack = VecInit(Seq(qLast, qExtra).reverse).asUInt

  def addShift(addValue: UInt) = {
    // val aNext = (((a + VecInit(Seq(addValue, 0.U(widthInput.W))).asUInt).asTypeOf(SInt(a.getWidth.W))) >> 1.U).asUInt
    val aNext = (a + addValue).asUInt
    val aqNext = (VecInit(Seq(aNext, q).reverse).asUInt.asSInt >> 1.U).asUInt
    val qExtraNext = qLast
    qExtra := qExtraNext
    a := aqNext(widthInput * 2 - 1, widthInput)
    q := aqNext(widthInput - 1, 0)
    printf("a: %b -> %b; aqNext: %b; q_-1: %b -> %b; addValue = %b\n", a, aNext, aqNext, qExtra, qExtraNext, addValue)
  }

  switch(state) {
    is(idleState) {
      q := io.y
      cnt := 0.U
      xReg := x
      minusXReg := minusX
      io.z := lastResultReg
      a := 0.U
    }
    is(runningState) {
      lastResultReg := 0.U
      printf("[%d state=%d] a=%b, q=%b, qExtra=%b, pack=%b, x=%b, -x=%b\n", cnt, state, a, q, qExtra, pack, xReg, minusXReg)
      addShift(MuxLookup(pack, 0.U, Array("b01".U -> xReg, "b10".U -> minusXReg)))
      cnt := cnt + 1.U
      io.busy := cnt =/= widthInput.U
    }
    is(outputState) {
      cnt := 0.U
      val result = VecInit(Seq(a, q).reverse).asUInt
      io.z := result
      printf("result = %b\n", result)
      lastResultReg := result
    }
  }
}
