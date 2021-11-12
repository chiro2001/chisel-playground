package test
 
// import chisel3._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}
 
object testClock extends App {
  // Driver.execute(args, () => new MyClock)
  (new chisel3.stage.ChiselStage).execute(args, Seq(ChiselGeneratorAnnotation(() => new MyClock)))
}