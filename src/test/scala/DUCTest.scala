package test
import org.scalatest._
import chiseltest._
import chisel3._
import scala.math._

import DUCMode._

class DUCTest extends FlatSpec with ChiselScalatestTester with Matchers {
  behavior of "DUC"
  it should "pass the test" in {
    val mode = DUC_125M
    test(new DUC(mode)) { c =>
      println("Starting test DUC...")
      val xList = if (mode == DUC_120M) List.range(0, 7) else List.range(0, 26)
      val yList = if (mode == DUC_120M) xList.map(x => (sin(x * 2 * Pi / 6) * 0x7F).toInt.S) else xList.map(x => (sin(x * 8 * Pi / 25) * 0x7F).toInt.S)
      c.io.in.data.poke(1.B)
      c.clock.step(1)
      c.io.in.clockDac.step(1)
      // c.io.out.dac.expect(yList(0).asTypeOf(UInt(8.W)))
      println("test done.")
    }
  }
}