import Foundation

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

  return (0.299 * Double(red)) +
    (0.587 * Double(green)) +
    (0.114 * Double(blue))
}

let characters: Array<String> = Array<String>([
  "$", "@", "B", "%", "h", "k", "b", "d", "p", "q", "w", "m",
  "O", "0", "Q", "C", "Y", "X",  "c", "x", "r", "j", "f", "t",
  "/", "\\", "|", "(", ")", "1", "{", "}", "[", "]", "-", "+", ";", ",", "\"", "^", "`",
  "\'", ",", ",", ".", ".", " ", " ", " ", " ", " ", " "
].reversed())

func toCharacter(grayScale: Double) -> String {
  let index = Int(grayScale / 255.0 * Double(characters.count - 1))

  return characters[index]
}
