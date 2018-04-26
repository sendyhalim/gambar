import Commander
import GambarImage

let main = command(
  Argument<String>("path", description: "Path to image")
) { path in
  do {
    let str = try ImageReader.asciiString(path: path)
    print(str)
  } catch {
    print("Error \(error)")
  }
}

main.run()
