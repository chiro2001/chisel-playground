package test 
import scala.math._
import chisel3._
import chisel3.util._
import chisel3.experimental.chiselName

@chiselName
class TestIO() extends Module {
  val io = IO(new Bundle {
    val out = Output(new Bundle {
      val data = SInt(8.W)
    })
  })

  def decode(v: UInt, out: SInt) = {
    when (v > 0x7F.U) {
      out := (v - 0x7F.U).asTypeOf(SInt(out.getWidth.W))
    } .otherwise {
      out := -(0x7F.U - v).asTypeOf(SInt(out.getWidth.W))
    }
  }

  // io.out.data := Cat(0x1F.U(8.W).asTypeOf(SInt(8.W)).asBools())
  // val v = 0x8E.U(8.W)
  // when (v > 0x7F.U) {
  //   io.out.data := (v - 0x7F.U).asTypeOf(SInt(8.W))
  // } .otherwise {
  //   io.out.data := -(0x7F.U - v).asTypeOf(SInt(8.W))
  // }

  decode(0x8E.U(8.W), io.out.data)
}