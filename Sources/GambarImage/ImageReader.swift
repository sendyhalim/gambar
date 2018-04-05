import Foundation
import SwiftGD
import Swiftz

public typealias RGBA = (Int, Int, Int, Double)

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

func toRGB(_ colorValue: Double) -> Int {
  return Int(colorValue * 255)
}

func pixelAtPoint(image: Image, point: Point) -> RGBA {
  let color = image.get(pixel: point)

  return (
    toRGB(color.redComponent),
    toRGB(color.greenComponent),
    toRGB(color.blueComponent),
    color.alphaComponent
  )
}

func groupPoints(by size: Int, pointMatrix: Array<Array<Point>>) -> Array<Array<Point>> {
  let splitted = pointMatrix.map {
    splitBy(f: { $0.y % size == 0 }, items: $0)
  }

  return splitted.dropFirst().reduce(splitted.first!) { acc, ys in
   return zipWith(f: (+), xs: acc, ys: ys)
  }
}

public struct ImageReader {
  public static func read(path: String) throws -> Image {
    guard File.exists(path: path) else {
      throw ImageReaderError.imageNotFound(path: path)
    }
    
    let url = URL(fileURLWithPath: path)

    return Image(url: url)!
  }

  public static func pixels(path: String) throws -> Array<Array<RGBA>> {
    let image = try read(path: path)
    let imagePixel = curry(pixelAtPoint)(image)
    let pointMatrix = points(width: image.size.width, height: image.size.height)

    return groupPoints(by: 3, pointMatrix: pointMatrix).map {
      $0.map(imagePixel)
    }
  }
}
