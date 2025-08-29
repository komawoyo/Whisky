<div align="center">

  # Whisky 🥃 
  *Wine but a bit stronger*
  
  ![](https://img.shields.io/github/actions/workflow/status/IsaacMarovitz/Whisky/SwiftLint.yml?style=for-the-badge)
  [![](https://img.shields.io/discord/1115955071549702235?style=for-the-badge)](https://discord.gg/CsqAfs9CnM)
</div>

## 🎉 Project Status Update

**Whisky is back!** The project has been revived with modern updates and improvements. We're committed to maintaining and enhancing Whisky for the macOS gaming community.

### What's New
- ✅ **macOS 15.0+ Support** - Latest macOS Sequoia compatibility
- ✅ **Swift 6.0 Upgrade** - Modern concurrency and performance improvements
- ✅ **Enhanced UI/UX** - Better animations, accessibility, and dark mode support
- ✅ **Performance Optimizations** - Caching, memory management, and async improvements
- ✅ **Security Enhancements** - Structured logging and error handling
- ✅ **Active Maintenance** - Regular updates and community support

<img width="650" alt="Config" src="https://github.com/Whisky-App/Whisky/assets/42140194/d0a405e8-76ee-48f0-92b5-165d184a576b">

Familiar UI that integrates seamlessly with macOS

<div align="right">
  <img width="650" alt="New Bottle" src="https://github.com/Whisky-App/Whisky/assets/42140194/ed1a0d69-d8fb-442b-9330-6816ba8981ba">

  One-click bottle creation and management
</div>

<img width="650" alt="debug" src="https://user-images.githubusercontent.com/42140194/229176642-57b80801-d29b-4123-b1c2-f3b31408ffc6.png">

Debug and profile with ease

---

Whisky provides a clean and easy to use graphical wrapper for Wine built in native SwiftUI. You can make and manage bottles, install and run Windows apps and games, and unlock the full potential of your Mac with no technical knowledge required. Whisky is built on top of CrossOver 22.1.1, and Apple's own `Game Porting Toolkit`.

Translated on [Crowdin](https://crowdin.com/project/whisky).

---

## System Requirements
- CPU: Apple Silicon (M-series chips)
- OS: macOS Sequoia 15.0 or later
- Memory: 8GB RAM recommended
- Storage: 2GB free space minimum

## Homebrew

Whisky is on homebrew! Install with
`brew install --cask whisky`.

## Building from Source

### Prerequisites
- Xcode 26.0 or later
- Swift 6.0 or later
- macOS Sequoia 15.0+

### Quick Build
```bash
# Clone the repository
git clone https://github.com/IsaacMarovitz/Whisky.git
cd Whisky

# Build WhiskyKit
cd WhiskyKit
swift build

# Build main app (from project root)
cd ..
xcodebuild -project Whisky.xcodeproj -scheme Whisky build
```

### Development Setup
```bash
# Install dependencies
brew install create-dmg

# Run tests
swift test

# Generate documentation
swift package generate-documentation
```

## Contributing

We welcome contributions! Here's how you can help:

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`swift test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style
- Follow Swift 6.0 best practices
- Use structured concurrency
- Add proper error handling
- Include accessibility support
- Write tests for new features

## My game isn't working!

Some games need special steps to get working. Check out the [wiki](https://github.com/IsaacMarovitz/Whisky/wiki/Game-Support).

## Support

- 📖 [Documentation](https://docs.getwhisky.app/)
- 📋 [Changelog](CHANGELOG.md)
- 💬 [Discord Community](https://discord.gg/CsqAfs9CnM)
- 🐛 [Issue Tracker](https://github.com/IsaacMarovitz/Whisky/issues)
- 📧 [Email Support](mailto:support@getwhisky.app)

---

---

## 🏗️ CI/CD Status

[![SwiftLint](https://github.com/IsaacMarovitz/Whisky/actions/workflows/SwiftLint.yml/badge.svg)](https://github.com/IsaacMarovitz/Whisky/actions/workflows/SwiftLint.yml)
[![Build & Test](https://github.com/IsaacMarovitz/Whisky/actions/workflows/build-test.yml/badge.svg)](https://github.com/IsaacMarovitz/Whisky/actions/workflows/build-test.yml)

## Credits & Acknowledgments

Whisky is possible thanks to the magic of several projects:

- [msync](https://github.com/marzent/wine-msync) by marzent
- [DXVK-macOS](https://github.com/Gcenx/DXVK-macOS) by Gcenx and doitsujin
- [MoltenVK](https://github.com/KhronosGroup/MoltenVK) by KhronosGroup
- [Sparkle](https://github.com/sparkle-project/Sparkle) by sparkle-project
- [SemanticVersion](https://github.com/SwiftPackageIndex/SemanticVersion) by SwiftPackageIndex
- [swift-argument-parser](https://github.com/apple/swift-argument-parser) by Apple
- [SwiftTextTable](https://github.com/scottrhoyt/SwiftyTextTable) by scottrhoyt
- [CrossOver 22.1.1](https://www.codeweavers.com/crossover) by CodeWeavers and WineHQ
- D3DMetal by Apple

Special thanks to Gcenx, ohaiibuzzle, and Nat Brown for their support and contributions!

---

<table>
  <tr>
    <td>
        <picture>
          <source media="(prefers-color-scheme: dark)" srcset="./images/cw-dark.png">
          <img src="./images/cw-light.png" width="500">
        </picture>
    </td>
    <td>
        Whisky doesn't exist without CrossOver. Support the work of CodeWeavers using our <a href="https://www.codeweavers.com/store?ad=1010">affiliate link</a>.
    </td>
  </tr>
</table>
