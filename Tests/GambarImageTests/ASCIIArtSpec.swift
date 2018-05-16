import Spectre
import Swiftz

@testable import GambarImage

struct ASCIIArtSpec {
  static let run: (ContextType) -> Void = {
    $0.describe("asciiArtSize(blockSize:actualSize:)") {
      $0.describe("when actualSize is divisible by blockSize") {
        $0.it("should shrink correctly") {
          let blockSize = Size(width: 3, height: 3)
          let actualSize = Size(width: 30, height: 60)
          let shrinkedSize = asciiArtSize(blockSize: blockSize, actualSize: actualSize)

          try expect(shrinkedSize.width) == 10
          try expect(shrinkedSize.height) == 20
        }
      }

      $0.describe("when actualSize is not divisible by blockSize") {
        $0.it("should shrink correctly") {
          let blockSize = Size(width: 3, height: 3)
          let actualSize = Size(width: 31, height: 67)
          let shrinkedSize = asciiArtSize(blockSize: blockSize, actualSize: actualSize)

          try expect(shrinkedSize.width) == 11
          try expect(shrinkedSize.height) == 23
        }
     }
    }
  }
}
