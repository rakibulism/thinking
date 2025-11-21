import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ClipboardItem.timestamp, order: .reverse) private var items: [ClipboardItem]
    @EnvironmentObject var clipboardManager: ClipboardManager
    
    @State private var hoverItemId: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("PulseClip")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    // Settings or Quit
                    NSApplication.shared.terminate(nil)
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(Color(nsColor: .windowBackgroundColor))
            
            // Timeline
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items) { item in
                        ClipboardCard(item: item, isHovering: hoverItemId == item.id)
                            .onHover { hovering in
                                hoverItemId = hovering ? item.id : nil
                            }
                            .onTapGesture {
                                pasteItem(item)
                            }
                    }
                }
                .padding()
            }
            .frame(maxHeight: 500)
        }
        .frame(width: 350)
        .background(Color(nsColor: .windowBackgroundColor))
    }
    
    private func pasteItem(_ item: ClipboardItem) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(item.content, forType: .string)
        
        // Simulate Cmd+V (Requires Accessibility permissions, skipping for MVP simplicity, 
        // user can just click to copy to clipboard then paste manually if needed, 
        // but ideally we automate this).
        // For now, we just put it back on top of clipboard so user can paste.
        print("Copied to clipboard: \(item.content)")
    }
}

struct ClipboardCard: View {
    let item: ClipboardItem
    let isHovering: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon / Type Indicator
            ZStack {
                Circle()
                    .fill(typeColor(item.type).opacity(0.2))
                    .frame(width: 32, height: 32)
                
                Image(systemName: typeIcon(item.type))
                    .foregroundColor(typeColor(item.type))
                    .font(.system(size: 14))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.sourceApp)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(item.timestamp, style: .time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Text(item.content)
                    .font(.system(size: 13))
                    .lineLimit(3)
                    .foregroundColor(.primary)
                
                if !item.tags.isEmpty {
                    HStack {
                        ForEach(item.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 4)
                }
            }
        }
        .padding(12)
        .background(isHovering ? Color.accentColor.opacity(0.1) : Color(nsColor: .controlBackgroundColor))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isHovering ? Color.accentColor.opacity(0.3) : Color.clear, lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: isHovering)
    }
    
    func typeColor(_ type: String) -> Color {
        switch type {
        case "link": return .blue
        case "code": return .purple
        case "email": return .orange
        default: return .gray
        }
    }
    
    func typeIcon(_ type: String) -> String {
        switch type {
        case "link": return "link"
        case "code": return "chevron.left.forwardslash.chevron.right"
        case "email": return "envelope"
        default: return "doc.text"
        }
    }
}
