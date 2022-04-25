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
  val a = RegInit(0.U((widthInput * 2).W))
  val qLast = RegInit(false.B)
  val cnt = RegInit(0.U(5.W))

  val states = Enum(3)
  val idleState :: runningState :: outputState :: Nil = states
  val state = RegInit(idleState)
  val nextState = Wire(UInt(log2Ceil(states.size).W))
  val stateMatrix = Array(
    idleState -> Mux(io.start, runningState, idleState),
    runningState -> Mux(cnt === 16.U, outputState, runningState),
    outputState -> idleState
  )
  nextState := MuxLookup(state, idleState, stateMatrix)
  state := nextState

  io.busy := false.B
  io.z := 0.U
  val x = io.x
  val minusX = -io.x

  def aLast = a(widthInput * 2 - 1).asBool

  def pack = VecInit(Seq(aLast, qLast)).asUInt

  def addShift(addValue: UInt) = {
    qLast := aLast
    a := (((a + VecInit(Seq(addValue, 0.U(widthInput.W))).asUInt).asTypeOf(SInt(a.getWidth.W))) >> 1.U).asUInt
  }

  when (state === runningState) {
    io.busy := true.B
    addShift(MuxLookup(pack, 0.U, Array(
      "b01".U -> x,
      "b10".U -> minusX
    )))
    cnt := cnt + 1.U
  } .otherwise {
    when (state === outputState) {
      io.z := a
    }
  }
}