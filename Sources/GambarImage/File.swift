import Foundation

struct File {
  static func exists(path: String) -> Bool {
    return FileManager.default.fileExists(atPath: path)
  }
}
