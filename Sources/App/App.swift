import SwiftUI
import SwiftData

@main
struct PulseClipApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarController: StatusBarController?
    var clipboardManager = ClipboardManager()
    
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
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Initialize Clipboard Manager context
        clipboardManager.setContext(sharedModelContainer.mainContext)
        
        // Initialize Status Bar Controller
        statusBarController = StatusBarController(
            modelContainer: sharedModelContainer,
            clipboardManager: clipboardManager
        )
    }
}
