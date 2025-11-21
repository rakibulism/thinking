import Foundation
import SwiftData

@Model
final class ClipboardItem {
    var id: UUID
    var content: String
    var type: String // "text", "image", "link", "code"
    var sourceApp: String
    var timestamp: Date
    var isPinned: Bool
    var tags: [String]
    
    init(content: String, type: String, sourceApp: String, tags: [String] = []) {
        self.id = UUID()
        self.content = content
        self.type = type
        self.sourceApp = sourceApp
        self.timestamp = Date()
        self.isPinned = false
        self.tags = tags
    }
}
