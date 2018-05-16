import Foundation

/// A structure that represents image Size
public struct Size {
  let width: Int
  let height: Int
}

/// A structure that represents a point in a bitmap image
public typealias BitmapPoint = (Int, Int)

/// Bitmap representation of an image
public protocol Bitmap {
  func color(point: BitmapPoint) -> Color.RGBA
  func getSize() -> Size
}
