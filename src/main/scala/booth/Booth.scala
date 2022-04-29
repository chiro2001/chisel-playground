package booth

import chisel3._
import chisel3.internal.naming.chiselName
import chisel3.util._

@chiselName
class Booth(widthInput: Int = 16) extends BoothPort(widthInput) {
  val width = widthInput
  val format = "b"
  val yReg = RegInit(0.U((width + 1).W))
  val sumReg = RegInit(0.S((width * 2).W))
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
  val xReg = RegInit(0.S((width * 2).W))

  val lastResultReg = RegInit(0.U((width * 2).W))

  def yRegLast = yReg(1, 0)

  def addShift(addValue: SInt) = {
    val add = addValue.asTypeOf(SInt((width * 2).W)) << cnt
    sumReg := sumReg + add
    yReg := yReg >> 1.U
    printf(
      s"yRegExtra = %$format, addValue = %$format, sum = %$format\n",
      yReg,
      add,
      sumReg.asUInt
    )
  }

  switch(state) {
    is(idleState) {
      cnt := 0.U
      xReg := io.x.asTypeOf(SInt(width.W))
      io.z := lastResultReg
      sumReg := 0.S
      yReg := io.y << 1.U
    }
    is(runningState) {
      println(f"width = $width, yRegLast size = ${yRegLast.getWidth}")
      lastResultReg := 0.U
      printf(
        s"[%d state=%$format], yReg=%$format, yRegLast=%$format, x=%$format, -x=%$format\n",
        cnt,
        state,
        yReg,
        yRegLast,
        xReg.asUInt,
        (-xReg).asUInt
      )
      addShift(MuxLookup(yRegLast, 0.S, Array("b01".U -> xReg, "b10".U -> -xReg)))
      cnt := cnt + 1.U
      io.busy := true.B
    }
    is(outputState) {
      cnt := 0.U
      val result = sumReg.asUInt
      io.z := result
      printf(s"result = %$format\n", result)
      lastResultReg := result
    }
  }
}
