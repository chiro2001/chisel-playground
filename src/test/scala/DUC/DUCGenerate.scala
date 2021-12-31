package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

import DUCMode._

object testDUC extends App {
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new DUC(DUC_125M))))
}