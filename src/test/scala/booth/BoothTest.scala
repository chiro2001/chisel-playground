package booth

import chisel3._
import chisel3.stage.PrintFullStackTraceAnnotation
import chiseltest._
import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should

class BoothTest
    extends AnyFlatSpec
    with ChiselScalatestTester
    with should.Matchers {
  behavior of "Booth"
  val widthInput = 16
  def getIntString(i: Int) = f"h$i%x"
  def getUInt(i: Int) = getIntString(i).U
  def testOnce[T <: BoothPort](d: T, x: String, y: String, z: String): Unit = {
    println(f"\ttesting: $x * $y = $z")
    d.io.x.poke(x.U)
    d.io.y.poke(y.U)
    d.clock.step(5)
    d.io.start.poke(true.B)
    d.clock.step(1)
    d.io.busy.expect(true.B)
    d.io.start.poke(false.B)
    d.clock.step(widthInput)
    d.io.busy.expect(false.B)
    d.io.z.expect(z.U)
    d.clock.step(10)
  }
  def testOnce[T <: BoothPort](d: T, a: Int, b: Int): Unit = {
    println(
      f"testing   : a(${getIntString(a)}) * b(${getIntString(b)}) = ${a * b}(${getIntString(a * b)})"
    )
    testOnce(d, getIntString(a), getIntString(b), getIntString(a * b))
    println(
      f"test done : a(${getIntString(a)}) * b(${getIntString(b)}) = ${a * b}(${getIntString(a * b)})"
    )
  }
  it should "pass multiply test" in {
    test(new Booth(widthInput)).withAnnotations(
      Seq(PrintFullStackTraceAnnotation, WriteVcdAnnotation)
    ) { d =>
      val testData = Seq(
        (0x1234, 0x1234),
      )
      testData.foreach(item => testOnce(d, item._1, item._2))
    }
  }
  it should "pass better multiply test" in {
    test(new BetterBooth(4)).withAnnotations(
      Seq(PrintFullStackTraceAnnotation, WriteVcdAnnotation)
    ) { d =>
      val testData = Seq(
        (getIntString(3), getIntString(7), getIntString(21)),
        ("b1101", "b1001", getIntString(21)),
        (getIntString(6), getIntString(5), getIntString(30)),
        ("b1010", "b1001", "b101010"),
      )
      testData.foreach(item => testOnce(d, item._1, item._2, item._3))
    }
  }
}
