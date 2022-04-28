package booth

import chisel3._

abstract class BoothPort(widthInput: Int = 16) extends Module {
  val io = IO(new Bundle {
    val x = Input(UInt(widthInput.W))
    val y = Input(UInt(widthInput.W))
    val busy = Output(Bool())
    val start = Input(Bool())
    val z = Output(UInt((widthInput * 2).W))
  })
}
