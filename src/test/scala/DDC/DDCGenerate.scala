package DDC

import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

import DDCMode._

object DDCGenerate extends App {
  (new chisel3.stage.ChiselStage).execute(Array("-td", "generated/DDC"), Seq(ChiselGeneratorAnnotation(() => new DDCWrapper(mode = DDC_60M))))
}