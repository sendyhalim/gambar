// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Gambar",
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", from: "1.2.0")
  ],
  targets: [
    .target(name: "GambarImage"),
    .target(
      name: "Gambar",
      dependencies: ["GambarImage"]
    ),
    .testTarget(
      name: "GambarTests",
      dependencies: ["GambarImage", "Quick", "Nimble"],
      path: "./Tests/"
    )
  ]
)
