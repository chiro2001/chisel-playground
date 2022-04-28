package booth

import chisel3._
import chiseltest._
import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should

class BoothTest extends AnyFlatSpec with ChiselScalatestTester with should.Matchers {
  behavior of "Booth"
  it should "pass multiply test" in {
    val widthInput = 4
    test(new Booth(widthInput)) { d =>
      println("generate RTL done")
      d.io.x.poke("b0110".U)
      d.io.y.poke("b0101".U)
      d.clock.step(5)
      d.io.start.poke(true.B)
      d.clock.step(1)
      d.io.busy.expect(true.B)
      d.io.start.poke(false.B)
      d.clock.step(widthInput)
      d.io.busy.expect(false.B)
      d.io.z.expect(30.U)
    }
  }
}
