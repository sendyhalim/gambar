import Spectre
import Swiftz

@testable import GambarImage

struct ImageReaderSpec {
  static let run: (ContextType) -> Void = {
    $0.describe("points(width:height:)") {
      $0.describe("given 0 width") {
        $0.it("should return empty points") {
          try expect(points(width: 0, height: 10).count) == 0
        }
      }

      $0.describe("given 0 height") {
        $0.it("should return empty points") {
          try expect(points(width: 10, height: 0).count) == 0
        }
      }

      $0.describe("given 3 width and 2 height") {
        $0.it("should return 6 points") {
          let _points = List(fromArray: points(width: 3, height: 2).map { ($0.x, $0.y) })
          let expectation = List(fromArray: [
            (0, 0), (0, 1),
            (1, 0), (1, 1),
            (2, 0), (2, 1)
          ])

          let correctResult = _points.mzip(expectation).reduce({ (acc, pairs) in
            let (result, expectation) = pairs

            return acc ? result == expectation : acc
          }, initial: true)

          try expect(_points.count) == 6
          try expect(correctResult) == true
        }
      }
    }
  }
}
