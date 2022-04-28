package booth

import chisel3._
import chisel3.stage.PrintFullStackTraceAnnotation
import chiseltest._
import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should

class BoothTest extends AnyFlatSpec with ChiselScalatestTester with should.Matchers {
  behavior of "Booth"
  it should "pass multiply test" in {
    val widthInput = 16
    test(new Booth(widthInput)).withAnnotations(Seq(PrintFullStackTraceAnnotation, WriteVcdAnnotation)) { d =>
      println("generate RTL done")
      def getIntString(i: Int) = "h" + bigintToHex(i).replace("0x", "")
      def getUInt(i: Int) = getIntString(i).U
      def testOnce(a: Int, b: Int): Unit = {
        println(f"testing   : a(${getIntString(a)}) * b(${getIntString(b)}) = ${a * b}(${getIntString(a * b)})")
        d.io.x.poke(getUInt(a))
        d.io.y.poke(getUInt(b))
        d.clock.step(5)
        d.io.start.poke(true.B)
        d.clock.step(1)
        d.io.busy.expect(true.B)
        d.io.start.poke(false.B)
        d.clock.step(widthInput)
        d.io.busy.expect(false.B)
        d.io.z.expect(getUInt(a * b))
        d.clock.step(10)
        println(f"test done : a(${getIntString(a)}) * b(${getIntString(b)}) = ${a * b}(${getIntString(a * b)})")
      }
      val testData = Seq(
        (0x1234, 0x1234),
      )
      // ++ (for {i <- 0 until 2} yield (scala.util.Random.nextInt(0xff), scala.util.Random.nextInt(0xff)))
      testData.foreach(item => testOnce(item._1, item._2))
    }
  }
}
