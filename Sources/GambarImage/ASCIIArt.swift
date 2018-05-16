import Foundation

/// Utility function to calculate sum of the given numbers.
func sum(_ numbers: Array<Double>) -> Double {
  return numbers.reduce(0, (+))
}

/// Utility function to calculate average of the given numbers.
func average(_ numbers: Array<Double>) -> Double {
  return sum(numbers) / Double(numbers.count)
}

/// Calculate ascii art size
func asciiArtSize(blockSize: Size, actualSize: Size) -> Size {
  return Size(
    width: Int(ceil(Double(actualSize.width) / Double(blockSize.width))),
    height: Int(ceil(Double(actualSize.height) / Double(blockSize.height)))
  )
}

/// Generate a character to represent block pixels located at the given cursor
func character(cursor: BitmapPoint, block: Size, image: Bitmap) -> String {
  let (cursorX, cursorY) = cursor
  let maxX = min((cursorX + block.width), Int(image.getSize().width))
  let maxY = min((cursorY + block.height), Int(image.getSize().height))

  let xs = Array(cursorX ..< maxX)
  let ys = Array(cursorY ..< maxY)

  let grayScales: Array<Double> = xs.flatMap { x in
    return ys.map { y in
      let color = image.color(point: (x, y))

      return toGrayScale(color: color)
    }
  }

  return toCharacter(grayScale: average(grayScales))
}

/// Calculate block size of the given image size.
func calculateBlockSize(size: Size) -> Size {
  return Size(
    width: Int(round(Double(size.width) / 200)),
    height: Int(round(Double(size.height) / 100))
  )
}

/// Generate an ASCII art where each character will represent
/// 1 block with size `blockSize`.
public func asciiArt(blockSize: Size, image: Bitmap) -> String {
  let size = asciiArtSize(blockSize: blockSize, actualSize: image.getSize())
  let xs = Array(0 ..< Int(size.width))
  let ys = Array(0 ..< Int(size.height))

  return ys.reduce("") { acc, y in
    let next = xs.reduce(acc) { acc, x in
      let cursor = (x * Int(blockSize.width), y * Int(blockSize.height))

      return acc + character(cursor: cursor, block: blockSize, image: image)
    }

    return next + "\n"
  }
}
