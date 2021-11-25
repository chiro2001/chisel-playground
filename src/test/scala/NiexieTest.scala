package test
import org.scalatest._
import chiseltest._
import chisel3._
import chiseltest.experimental.TestOptionBuilder._
import chiseltest.internal.WriteVcdAnnotation

class NiexieTest extends FlatSpec with ChiselScalatestTester with Matchers {
  behavior of "Niexie"
  it should "pass the test" in {
    test(new Niexie).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      println("Starting test Niexie...")

      
      // val ledCount = 0
      // c.io.button.poke(1.U)
      // c.io.ledCount.get.poke(ledCount.U)
      // c.clock.step(2)
      // c.io.led.expect((ledCount + 1).U)
      // // printf(s"c.io.led: ${c.io.led.peek()}\n")

      // c.io.button.poke(0.U)
      // c.clock.step()
      // c.io.led.expect((ledCount + 1).U)
      // c.clock.step()
      // c.clock.step()
      // c.clock.step()
      // c.clock.step()
      // c.io.led.expect(((ledCount + 1) << 1).U)
      // // c.io.led.expect(ledCount.U << 1.U)
      // // c.io.led.expect(((1 << ledCount) - 1).U)
      println("test done.")
    }
  }
}
