import Foundation
import Spectre

@testable import GambarImage

func imageFixturePath(_ imageFile: String) -> String {
  var splitted = #file.split(separator: "/").map(String.init)
  _ = splitted.removeLast()
  let currentDirectory = "/" + splitted.joined(separator: "/")

  return "\(currentDirectory)/../fixtures/\(imageFile)"
}

struct FileSpec {
  static let run: (ContextType) -> Void = {
    $0.describe(".exists(path:)") {
      $0.describe("when given invalid image path") {
        $0.it("should return false") {
          try expect(File.exists(path: imageFixturePath("imag.jpeg"))) == false
        }
      }

      $0.describe("when given valid image path") {
        $0.it("should return true") {
          try expect(File.exists(path: imageFixturePath("image.jpeg"))) == true
        }
      }
    }
  }
}
