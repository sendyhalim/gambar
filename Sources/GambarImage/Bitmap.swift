import Foundation

/// A structure that represents image Size
public struct Size {
  let width: Int
  let height: Int
}

/// A structure that represents a point in a bitmap image
public protocol BitmapPoint {
  var x: Int { get }
  var y: Int { get }
}

public protocol Bitmap {
  func color(point: BitmapPoint) -> Color.RGBA
  func getSize() -> Size
}
