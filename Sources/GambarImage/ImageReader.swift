import Foundation
import SwiftGD
import Swiftz
import Operadics

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
}

func points(width: Int, height: Int) -> List<Point> {
  let xs = List(fromArray: Array(0 ..< width))
  let ys = List(fromArray: Array(0 ..< height))

  return curry(Point.init) <^> xs <*> ys
}

public struct ImageReader {
  public func read(path: String) throws -> Image {
    guard File.exists(path: path) else {
      throw ImageReaderError.imageNotFound(path: path)
    }
    
    let url = URL(fileURLWithPath: path)

    return Image(url: url)!
  }
}
