package lang

import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should

class BundleOrderTest
    extends AnyFlatSpec
    with should.Matchers {
  behavior of "Bundle"
  it should "pass lang test" in {
    println("lang test done.")
  }
}
