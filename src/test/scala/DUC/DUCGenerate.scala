package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

import DUCMode._

object testDUC extends App {
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new DUCWrapper(DUC_120M))))
}