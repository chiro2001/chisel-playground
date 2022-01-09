package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

import DDCMode._

object testDDC extends App {
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new DDCWrapper(mode = DDC_200M))))
}