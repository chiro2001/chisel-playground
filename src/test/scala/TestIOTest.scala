package test
import org.scalatest._
import chiseltest._
import chisel3._
import scala.math._

import DUCMode._

class TestIOTest extends FlatSpec with ChiselScalatestTester with Matchers {
  behavior of "TestIO"
  it should "pass the test" in {
    test(new TestIO) { c =>
      println("Starting test testIO...")
      c.io.out.data.expect(0xf.S)
      println("test done.")
    }
  }
}