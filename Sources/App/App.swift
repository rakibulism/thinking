import SwiftUI

@main
struct FutureVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
                .background(Color(red: 0.04, green: 0.04, blue: 0.04)) // Dark background
        }
        .windowStyle(.hiddenTitleBar)
    }
}
