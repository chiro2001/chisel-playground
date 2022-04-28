package booth

import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

object boothGenerate extends App {
  (new chisel3.stage.ChiselStage).execute(Array("-td", "generated/booth"), Seq(ChiselGeneratorAnnotation(() => new Booth(widthInput = 16))))
}