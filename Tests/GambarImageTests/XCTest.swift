import XCTest
import Spectre

class GambarImageTests: XCTestCase {
  func testGambarImage() {
    describe("FileSpec", FileSpec.run)
    describe("ArrayUtilsSpec", ArrayUtilsSpec.run)
    describe("ImageReaderSpec", ImageReaderSpec.run)
  }
}
