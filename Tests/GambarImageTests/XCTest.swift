import XCTest
import Spectre

class GambarImageTests: XCTestCase {
  func testFileSpec() {
    describe("FileSpec", FileSpec.run)
  }

  func testASCIIArtSpec() {
    describe("ASCIIArtSpec", ASCIIArtSpec.run)
  }
}
