package test
import org.scalatest._
import chiseltest._
import chisel3._

class FlowLightsTest extends FlatSpec with ChiselScalatestTester with Matchers {
  behavior of "FlowLightsWrapper"
  it should "pass the test" in {
    test(new FlowLightsWrapper(ledWidth=16, delay=2, useSwitch=true)) { c =>
      println("Starting test FlowLights...")
      val ledCount = 3
      c.io.button.poke(1.U)
      c.io.ledCount.get.poke(ledCount.U)
      c.clock.step()
      // c.io.led.expect(ledCount.U)
      printf(s"c.io.led: ${Binary(c.io.led.peek())}\n")

      c.io.button.poke(0.U)
      c.clock.step()
      c.io.led.expect(((1 << ledCount) - 1).U)
      println("test done.")
    }
  }
}
