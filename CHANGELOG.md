# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - 2024-12-XX

### 🎉 Revival & Major Updates
- **Project Revival**: Whisky is back with active maintenance and regular updates
- **macOS 15.0+ Support**: Full compatibility with macOS Sequoia
- **Swift 6.0 Upgrade**: Modern concurrency patterns and performance improvements
- **UI/UX Enhancements**: Better animations, accessibility, and dark mode support
- **Performance Optimizations**: Caching, memory management, and async improvements
- **Security Improvements**: Structured logging and enhanced error handling

### Added
- Modern animation API with spring interpolations
- Accessibility labels and hints for VoiceOver support
- Status indicators for bottle availability
- Structured logging with OSLog framework
- Result-based error handling in WhiskyWineInstaller
- Performance caching for bottle operations
- Memory optimization for pinned programs computation

### Changed
- Updated Swift tools version to 6.0
- Improved concurrency with structured async/await
- Enhanced error handling throughout the application
- Better dark mode support with semantic colors
- Updated system requirements to macOS 15.0+

### Technical Improvements
- Replaced `Task.detached` with structured concurrency
- Added `@MainActor` annotations for thread safety
- Implemented caching mechanisms for frequently accessed data
- Enhanced Wine process management with proper async handling
- Improved file system operations with better error handling

### Fixed
- Memory leaks in bottle management
- Thread safety issues with concurrent operations
- Inconsistent error reporting
- Performance bottlenecks in UI updates

### Developer Experience
- Updated build instructions for modern development
- Added comprehensive contribution guidelines
- Enhanced documentation with development workflows
- CI/CD pipeline setup for automated testing

## [2.x.x] - Previous Versions
- Legacy Whisky versions (see git history for details)

---

## Contributing to Changelog
- Please follow the format above
- Use appropriate emoji prefixes for different types of changes
- Keep entries concise but descriptive
- Group similar changes together
