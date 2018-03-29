import Foundation
import SwiftGD

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
}

func points(width: Int, height: Int) -> Array<Point> {
  let xs = Array(0 ..< width)
  let ys = Array(0 ..< height)

  return xs.flatMap { x in
    ys.map { y in Point(x: x, y: y) }
  }
}

func toRGB(_ colorValue: Double) -> Int {
  return Int(colorValue * 255)
}

public typealias RGBA = (Int, Int, Int, Double)

public struct ImageReader {
  public static func read(path: String) throws -> Image {
    guard File.exists(path: path) else {
      throw ImageReaderError.imageNotFound(path: path)
    }
    
    let url = URL(fileURLWithPath: path)

    return Image(url: url)!
  }

  public static func pixels(path: String) throws -> Array<RGBA> {
    let image = try read(path: path)

    return points(width: image.size.width, height: image.size.height).map { point in
      let color = image.get(pixel: point)

      return (
        toRGB(color.redComponent),
        toRGB(color.greenComponent),
        toRGB(color.blueComponent),
        color.alphaComponent
      )
    }
  }
}
