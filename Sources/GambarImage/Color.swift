public struct Color {
  public typealias RGBA = (Int, Int, Int, Double)
}

func doubleToRGBBased(doubleValue: Double) -> Int {
  return Int(doubleValue * 255)
}

func toRGBA(red: Double, green: Double, blue: Double, alpha: Double) -> Color.RGBA {
  return (
    doubleToRGBBased(doubleValue: red),
    doubleToRGBBased(doubleValue: green),
    doubleToRGBBased(doubleValue: blue),
    alpha
  )
}

func times(_ lhs: Int, _ rhs: Double) -> Int {
  return Int(Double(lhs) * rhs)
}

func toGrayScale(color: Color.RGBA) -> Color.RGBA {
  let (red, green, blue, alpha) = color

  return (
    times(red, 0.21),
    times(green, 0.72),
    times(blue, 0.07),
    alpha
  )
}
