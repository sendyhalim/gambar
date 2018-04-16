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

func toGrayScale(color: Color.RGBA) -> Double {
  let (red, green, blue, _) = color

  return 0.299 * Double(red) + 0.587 * Double(green) + 0.114 * Double(blue)
}

func toCharacter(grayScale: Double) -> String {
  switch grayScale {
  case 0..<50:
    return "@"

  case 50..<70:
    return "#"

  case 70..<100:
    return "8"

  case 100..<130:
    return "&"

  case 130..<160:
    return "o"

  case 160..<180:
    return ":"

  case 180..<200:
    return "*"

  case 200..<230:
    return "."

 default:
    return " "
  }
}
