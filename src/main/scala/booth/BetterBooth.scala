package booth

import chisel3._
import chisel3.internal.naming.chiselName
import chisel3.util._

@chiselName
class BetterBooth(widthInput: Int = 16) extends BoothPort {
  val width = widthInput
  val format = "b"
  val yReg = RegInit(0.U((width + 3).W))
  val sumReg = RegInit(0.S((width * 2).W))
  val cnt = RegInit(0.U(log2Ceil(width).W))

  val states = Enum(3)
  val idleState :: runningState :: outputState :: Nil = states
  val state = RegInit(idleState)
  val nextState = Wire(UInt(log2Ceil(states.size).W))
  val stateMatrix = Array(
    idleState -> Mux(io.start, runningState, idleState),
    runningState -> Mux(cnt === (width / 2).U, outputState, runningState),
    outputState -> idleState
  )
  nextState := MuxLookup(state, idleState, stateMatrix)
  state := nextState

  io.busy := false.B
  io.z := 0.U
  val xReg = RegInit(0.S((width * 2).W))

  val lastResultReg = RegInit(0.U((width * 2).W))

  def yRegLast = yReg(2, 0)

  def addShift(addValue: SInt) = {
    val add = addValue.asTypeOf(SInt((width * 2).W)) << (cnt << 1.U)
    sumReg := sumReg + add
    yReg := yReg >> 2.U
    printf(
      s"yRegExtra = %$format, addValue = %$format, sum = %$format\n",
      yReg,
      add,
      sumReg.asUInt
    )
  }

  def get2XReg = (xReg << 1.U).asSInt

  switch(state) {
    is(idleState) {
      cnt := 0.U
      xReg := io.x.asTypeOf(SInt(width.W))
      io.z := lastResultReg
      yReg := (io.y << 1.U).asUInt + Mux(io.y.asTypeOf(SInt(width.W)) < 0.S, "b11".U((width + 3).W) << (width + 1).U, 0.U)
      sumReg := 0.S
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
      addShift(
        MuxLookup(
          yRegLast,
          0.S,
          Array(
            "b001".U -> xReg,
            "b010".U -> xReg,
            "b011".U -> get2XReg,
            "b100".U -> -get2XReg,
            "b101".U -> -xReg,
            "b110".U -> -xReg
          )
        )
      )
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
