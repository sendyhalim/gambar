import Foundation
import SwiftGD
import Swiftz

extension Point: BitmapPoint { }

extension Image: Bitmap {
  public func color(point: BitmapPoint) -> Color.RGBA {
    let color = get(pixel: point as! Point)

    return toRGBA(
      red: color.redComponent,
      green: color.greenComponent,
      blue: color.blueComponent,
      alpha: color.alphaComponent
    )
  }


  public func getSize() -> Size {
    return Size(width: size.width, height: size.height)
  }
}

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
}


func sum(_ numbers: Array<Double>) -> Double {
  return numbers.reduce(0, (+))
}

func average(_ numbers: Array<Double>) -> Double {
  return sum(numbers) / Double(numbers.count)
}

func shrink(blockSize: Size, actualSize: Size) -> Size {
  return Size(
    width: Int(ceil(Double(actualSize.width) / Double(blockSize.width))),
    height: Int(ceil(Double(actualSize.height) / Double(blockSize.height)))
  )
}

func character(cursor: BitmapPoint, block: Size, image: Bitmap) -> String {
  let maxX = min((cursor.x + block.width), Int(image.getSize().width))
  let maxY = min((cursor.y + block.height), Int(image.getSize().height))

  let xs = Array(cursor.x ..< maxX)
  let ys = Array(cursor.y ..< maxY)

  let grayScales: Array<Double> = xs.flatMap { x in
    return ys.map { y in
      let color = image.color(point: Point(x: x, y: y))

      return toGrayScale(color: color)
    }
  }

  return toCharacter(grayScale: average(grayScales))
}

func asciiArt(blockSize: Size, image: Bitmap) -> String {
  let shrinkedSize = shrink(blockSize: blockSize, actualSize: image.getSize())
  let xs = Array(0 ..< Int(shrinkedSize.width))
  let ys = Array(0 ..< Int(shrinkedSize.height))

  return ys.reduce("") { acc, y in
    let next = xs.reduce(acc) { acc, x in
      let cursor = Point(x: x * Int(blockSize.width), y: y * Int(blockSize.height))

      return acc + character(cursor: cursor, block: blockSize, image: image)
    }

    return next + "\n"
  }
}

func calculateBlockSize(size: Size) -> Size {
  return Size(
    width: Int(round(Double(size.width) / 200)),
    height: Int(round(Double(size.height) / 100))
  )
}

public struct ImageReader {
  public static func read(path: String) throws -> Image {
    guard File.exists(path: path) else {
      throw ImageReaderError.imageNotFound(path: path)
    }

    let url = URL(fileURLWithPath: path)

    return Image(url: url)!
  }

  public static func asciiString(path: String) throws -> String {
    let image = try read(path: path)
    let blockSize = calculateBlockSize(size: image.getSize())

    return asciiArt(blockSize: blockSize, image: image)
  }
}
