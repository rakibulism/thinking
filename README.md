# PulseClip (macOS)

A tiny menu-bar clipboard that keeps the context of every copy.

## ✨ Features

- **Context Visualization**: See the source app and type of every clip.
- **Smart Tagging**: Auto-tags links, code, and emails.
- **Timeline View**: A clean, scrollable history of your clipboard.
- **Native Performance**: Built with SwiftUI and SwiftData.

## 🚀 Running the App

> [!NOTE]
> Requires macOS 14.0 (Sonoma) or later.

### Recommended: Open in Xcode
1. Double-click `Package.swift` to open the project in Xcode.
2. Ensure the target is set to "My Mac".
3. Press `Cmd + R` to build and run.

### Terminal
```bash
swift run
```
*Note: If you encounter linker errors in the terminal, please use the Xcode method above.*

## 📂 Project Structure

- `Package.swift`: Project configuration.
- `Sources/App/App.swift`: MenuBarExtra entry point.
- `Sources/App/ClipboardManager.swift`: Clipboard monitoring logic.
- `Sources/App/ContentView.swift`: Main timeline UI.
- `Sources/App/ItemModel.swift`: SwiftData model.

---
© 2024 PulseClip. All rights reserved.
