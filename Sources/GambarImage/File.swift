import Foundation

struct File {
  func exists(path: String) -> Bool {
    return FileManager.default.fileExists(atPath: path)
  }
}
