package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

object testDDC extends App {
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new DDCWrapper)))
}