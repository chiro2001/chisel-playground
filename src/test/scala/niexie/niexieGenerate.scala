package test
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

object testNiexie extends App {
  // chisel3.Driver.execute(args, () => new Niexie)
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new Niexie)))
}