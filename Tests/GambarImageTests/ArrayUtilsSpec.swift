import Spectre

@testable import GambarImage

struct ArrayUtilsSpec {
  static let run: (ContextType) -> Void = {
    $0.describe("splitBy()") {
      $0.context("given empty array") {
        $0.it("should return empty array") {
          try expect(splitBy(f: { _, _ in true }, items: []).count) == 0
        }
      }

      $0.context("given uneven split condition") {
        $0.it("should split correctly") {
          let result = splitBy(f: { item, index in
            (item % 3) == 0
          }, items: [0, 1, 2, 3, 4, 5, 6, 7])
          
          let expectations = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7]
          ]

          try expect(result.count) == 3

          for i in (0 ..< result.count) {
            try expect(result[i]) == expectations[i]
          }
        }
      }
    }

    $0.describe("zipWith()") {
      $0.context("given empty arrays") {
        func tuple<T> (x: T, y: T) -> (T, T) {
          return (x, y)
        }

        $0.it("should return empty array") {
          try expect(zipWith(f: tuple, xs: [], ys: []).count) == 0
        }
      }

      $0.context("given array with same size") {
        $0.it("should zip all of the items") {
          let result = zipWith(f: (+), xs: [1, 2, 3], ys: [4, 5, 6])

          try expect(result) == [5, 7, 9]
        }
      }

      $0.context("given matrix") {
        $0.it("should zip the matrix properly") {
          let result = zipWith(f: (+), xs: [[1, 2], [4], [5, 6, 7]], ys: [[9, 10, 11], [99, 88, 77], [3]])

          let expectations = [
            [1, 2, 9, 10, 11],
            [4, 99, 88, 77],
            [5, 6, 7, 3]
          ]

          for i in (0 ..< result.count) {
            try expect(result[i]) == expectations[i]
          }
        }
      }

      $0.context("given smaller right operand array") {
        $0.it("should zip until the smallest-sized array") {
          let result = zipWith(f: (+), xs: [1, 2, 3], ys: [4, 5])

          try expect(result) == [5, 7]
        }
      }

      $0.context("given smaller left operand array") {
        $0.it("should zip until the smallest-sized array") {
          let result = zipWith(f: (+), xs: [2, 3], ys: [4, 5, 7])

          try expect(result) == [6, 8]
        }
      }
    }
  }
}
