package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

import DUCMode._

object testFrameTrigger extends App {
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new FrameTriggerWrapper(chunkSize = 3))))
}