// AND.scala
package test
 
import chisel3._
import chisel3.experimental._
 
class AND extends Module {
  val io = IO(new Bundle {
    val on_done = Output(UInt(1.W))
  })

  def generateClock(n: Int) = {
    val cntReg = RegInit(0.U(8.W))
    cntReg := Mux(cntReg === n.U, 0.U, cntReg + 1.U)
    cntReg
  }

  val clock = generateClock(4)
 
  io.on_done = Mux(clock == 0.U, 0.U, 1.U)
}