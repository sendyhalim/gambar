test:
	swift test

generate-xcode-project:
	swift package generate-xcodeproj

install-dependencies:
	swift package update

bootstrap:
	make install-dependencies
	make generate-xcode-project

install:
	swift build --configuration release
	cp $(shell swift build --show-bin-path --configuration release)/gambar /usr/local/bin/gambar

.PHONY: generate-xcode-project install-dependencies test
