import SwiftUI
import SwiftData

@main
struct PulseClipApp: App {
    @StateObject private var clipboardManager = ClipboardManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ClipboardItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        MenuBarExtra("PulseClip", systemImage: "paperclip.circle.fill") {
            ContentView()
                .modelContainer(sharedModelContainer)
                .environmentObject(clipboardManager)
                .onAppear {
                    clipboardManager.setContext(sharedModelContainer.mainContext)
                }
        }
        .menuBarExtraStyle(.window) // Allows for a rich view
    }
}
