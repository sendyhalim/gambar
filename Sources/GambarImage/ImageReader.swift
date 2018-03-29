import Foundation
import SwiftGD

public enum ImageReaderError: Swift.Error {
  case imageNotFound(path: String)
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
