import Foundation
import Quick
import Nimble

@testable import GambarImage

func imageFixturePath(_ imageFile: String) -> String {
  var splitted = #file.split(separator: "/").map(String.init)
  _ = splitted.removeLast()
  let currentDirectory = "/" + splitted.joined(separator: "/")

  return "\(currentDirectory)/../fixtures/\(imageFile)"
}

class FileSpec: QuickSpec {
  override func spec() {
    describe(".exists(path:)") {
      describe("when given invalid image path") {
        it("should return false") {
          expect(File.exists(path: imageFixturePath("imag.jpeg"))) == false
        }
      }

      describe("when given valid image path") {
        it("should return true") {
          expect(File.exists(path: imageFixturePath("image.jpeg"))) == true
        }
      }
    }
  }
}
