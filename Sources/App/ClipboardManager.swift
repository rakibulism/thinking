import SwiftUI
import AppKit
import SwiftData

class ClipboardManager: ObservableObject {
    private var lastChangeCount: Int
    private let pasteboard = NSPasteboard.general
    
    // We will use a callback or binding to save to context, 
    // or just expose a published property and let the View handle saving.
    // For a background agent, passing the ModelContext is cleaner.
    var modelContext: ModelContext?
    
    init() {
        self.lastChangeCount = pasteboard.changeCount
        
        // Start a timer to check for clipboard changes
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkForChanges()
        }
    }
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    private func checkForChanges() {
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount
        
        guard let items = pasteboard.pasteboardItems?.first else { return }
        
        if let string = items.string(forType: .string) {
            saveItem(content: string, type: determineType(string))
        }
        // Add image handling later
    }
    
    private func saveItem(content: String, type: String) {
        guard let context = modelContext else { return }
        
        let sourceApp = NSWorkspace.shared.frontmostApplication?.localizedName ?? "Unknown"
        let tags = generateTags(content: content, type: type)
        
        let newItem = ClipboardItem(content: content, type: type, sourceApp: sourceApp, tags: tags)
        
        Task { @MainActor in
            context.insert(newItem)
            try? context.save()
            print("Saved: \(content.prefix(20))... from \(sourceApp)")
        }
    }
    
    private func determineType(_ content: String) -> String {
        if content.hasPrefix("http") { return "link" }
        if content.contains("{") && content.contains("}") { return "code" }
        return "text"
    }
    
    private func generateTags(content: String, type: String) -> [String] {
        var tags: [String] = []
        if type == "link" { tags.append("link") }
        if type == "code" { tags.append("code") }
        if content.lowercased().contains("email") || content.contains("@") { tags.append("email") }
        if content.count < 50 { tags.append("snippet") }
        return tags
    }
}
