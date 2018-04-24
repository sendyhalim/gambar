import Foundation
import SwiftGD
import Swiftz

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
}

func colorAtPoint(image: Image, point: Point) -> Color.RGBA {
  let color = image.get(pixel: point)

  return toRGBA(
    red: color.redComponent,
    green: color.greenComponent,
    blue: color.blueComponent,
    alpha: color.alphaComponent
  )
}

func average(numbers: Array<Double>) -> Double {
  return numbers.reduce(0, (+)) / Double(numbers.count)
}

func shrink(blockSize: Size, actualSize: Size) -> Size {
  return Size(
    width: Int(ceil(Double(actualSize.width) / Double(blockSize.width))),
    height: Int(ceil(Double(actualSize.height) / Double(blockSize.height)))
  )
}

func character(cursor: Point, block: Size, image: Image) -> String {
  let maxX = min((cursor.x + block.width), image.size.width)
  let maxY = min((cursor.y + block.height), image.size.height)

  let xs = Array(cursor.x ..< maxX)
  let ys = Array(cursor.y ..< maxY)

  let grayScales: Array<Double> = xs.flatMap { x in
    return ys.map { y in
      let color = colorAtPoint(image: image, point: Point(x: x, y: y))

      return toGrayScale(color: color)
    }
  }

  return toCharacter(grayScale: average(numbers: grayScales))
}

func asciiArt(blockSize: Size, image: Image) -> String {
  let shrinkedSize = shrink(blockSize: blockSize, actualSize: image.size)
  let xs = Array(0 ..< shrinkedSize.width)
  let ys = Array(0 ..< shrinkedSize.height)

  return ys.reduce("") { acc, y in
    let next = xs.reduce(acc) { acc, x in
      let cursor = Point(x: x * blockSize.width, y: y * blockSize.height)

      return acc + character(cursor: cursor, block: blockSize, image: image)
    }

    return next + "\n"
  }
}

func calculateBlockSize(size: Size) -> Size {
  return Size(
    width: Int(round(Double(size.width) / 100)),
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
    let blockSize = calculateBlockSize(size: image.size)

    return asciiArt(blockSize: blockSize, image: image)
  }
}
