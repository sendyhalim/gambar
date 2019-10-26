import Commander
import GambarImage

let main = command(
  Argument<String>("path", description: "Path to image"),
  Option("block-size-width-denominator", default: 200),
  Option("block-size-height-denominator", default: 100)
) { path, blockSizeWidthDenominator, blockSizeHeightDenominator in
  do {
    let str = try ImageReader.asciiString(
      path: path,
      blockSizeWidthDenominator: blockSizeWidthDenominator,
      blockSizeHeightDenominator: blockSizeHeightDenominator
    )
    
    print(str)
  } catch {
    print("Error \(error)")
  }
}

main.run()
