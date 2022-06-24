package bundle

import chisel3._
import chisel3.stage.PrintFullStackTraceAnnotation
import chiseltest._
import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should

class BundleOrderTest
    extends AnyFlatSpec
    with ChiselScalatestTester
    with should.Matchers {
  behavior of "Bundle"

  class TestBundleModule extends Module {
    class Foo extends Bundle {
      val a = UInt(3.W)
      val b = UInt(5.W)
    }
    val foo = Wire(new Foo)
    foo.a := "b100".U
    foo.b := "b11000".U
    val bar = foo.asTypeOf(UInt(8.W))
    val io = IO(Output(new Bundle {
      val foo = new Foo
      val bar = UInt(8.W)
    }))
    io.foo := foo
    io.bar := bar
    printf("bar: %b\n", bar)
  }

  it should "test order" in {
    test(new TestBundleModule).withAnnotations(
      Seq(PrintFullStackTraceAnnotation, WriteVcdAnnotation)
    ) { d =>
      d.clock.step(3)
      val bar = d.io.bar.peekInt()
      println(s"outer: bar: $bar")
    }
  }
}
