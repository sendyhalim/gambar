generate-xcode-project:
	swift package generate-xcodeproj

install-dependencies:
	swift package update
	make generate-xcode-project

.PHONY: generate-xcode-project install-dependencies
