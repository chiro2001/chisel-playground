// AND.scala
package test
 
import chisel3._
import chisel3.experimental._
// import chisel3.experimental.chiselName
 
@chiselName
class MyClock extends Module {
  val io = IO(new Bundle {
    val onDone = Output(UInt(1.W))
  })

  def generateClock(n: Int) = {
    val cntReg = RegInit(0.U(8.W))
    cntReg := Mux(cntReg === n.U, 0.U, cntReg + 1.U)
    cntReg
  }

  val clkReg = generateClock(4)
 
  io.onDone := Mux(clkReg === 0.U, 0.U, 1.U)
}