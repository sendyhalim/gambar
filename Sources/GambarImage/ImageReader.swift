import Foundation
import SwiftGD
import Swiftz

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
}

func points(width: Int, height: Int) -> Array<Array<Point>> {
  let xs = Array(0 ..< width)
  let ys = Array(0 ..< height)

  return xs.map { x in
    ys.map(curry(Point.init)(x))
  }
}

func pixelAtPoint(image: Image, point: Point) -> Color.RGBA {
  let color = image.get(pixel: point)

  return toRGBA(
    red: color.redComponent,
    green: color.greenComponent,
    blue: color.blueComponent,
    alpha: color.alphaComponent
  )
}

func groupPoints(by size: Size, pointMatrix: Array<Array<Point>>) -> Array<Array<Array<Point>>> {
  let matrixSize = size.width * size.height
  let splitted = pointMatrix.map {
    splitBy(
      f: { _, index in
        (index % size.height) == 0
      },
      items: $0
    )
  }

  return splitted
    .dropFirst()
    .reduce(splitted.first!) { acc, ys in
      return zipWith(f: (+), xs: acc, ys: ys)
    }
    .map {
      splitBy(
        f: { _, index in
          (index % matrixSize) == 0
        },
        items: $0
      )
    }
}

func average(numbers: Array<Double>) -> Double {
  return numbers.reduce(0, (+)) / Double(numbers.count)
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
    let grayScalePixel = {
      toGrayScale(color: pixelAtPoint(image: image, point: $0))
    }
    let pointMatrix = points(width: image.size.width, height: image.size.height)
    let size = Size(width: 3, height: 3)

    return groupPoints(by: size, pointMatrix: pointMatrix)
      .map { groups in
        groups
          .map { $0.map(grayScalePixel) }
          .map(average)
          .map(toCharacter)
          .reduce("", (+))
      }
      .joined(separator: "\n")
  }
}
