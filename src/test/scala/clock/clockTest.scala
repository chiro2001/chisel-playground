package test
 
import chisel3._
 
object testClock extends App {
  Driver.execute(args, () => new Clock)
}