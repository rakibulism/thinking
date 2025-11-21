import Cocoa
import SwiftUI
import SwiftData
import Carbon

class StatusBarController: NSObject {
    private var statusItem: NSStatusItem
    private var panel: FloatingPanel
    private var hotKeyRef: EventHotKeyRef?
    
    init(modelContainer: ModelContainer, clipboardManager: ClipboardManager) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        let contentView = ContentView()
            .modelContainer(modelContainer)
            .environmentObject(clipboardManager)
        
        let hostingView = NSHostingView(rootView: contentView)
        
        panel = FloatingPanel(
            contentRect: NSRect(x: 0, y: 0, width: 350, height: 500),
            backing: .buffered,
            defer: false
        )
        panel.contentView = hostingView
        
        super.init()
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "paperclip.circle.fill", accessibilityDescription: "PulseClip")
            button.action = #selector(togglePanel)
            button.target = self
        }
        
        setupGlobalHotkey()
        
        // Hide panel when clicking outside
        NSEvent.addLocalMonitorForEvents(matching: .leftMouseDown) { [weak self] event in
            if let panel = self?.panel, panel.isVisible && event.window != panel {
                self?.hidePanel()
            }
            return event
        }
        
        // Global monitor for clicks outside (when app is not active)
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] _ in
            self?.hidePanel()
        }
    }
    
    @objc func togglePanel() {
        if panel.isVisible {
            hidePanel()
        } else {
            showPanel()
        }
    }
    
    func showPanel() {
        guard let button = statusItem.button else { return }
        
        let buttonFrame = button.window?.convertToScreen(button.frame) ?? .zero
        let panelSize = panel.frame.size
        
        let x = buttonFrame.origin.x - (panelSize.width / 2) + (buttonFrame.width / 2)
        let y = buttonFrame.origin.y - panelSize.height - 5
        
        panel.setFrameOrigin(NSPoint(x: x, y: y))
        panel.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    func hidePanel() {
        panel.orderOut(nil)
    }
    
    // MARK: - Hotkey Setup
    private func setupGlobalHotkey() {
        // Register Cmd+Shift+V
        var hotKeyID = EventHotKeyID(signature: 0x1234, id: 1)
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: OSType(kEventHotKeyPressed))
        
        // Install handler
        InstallEventHandler(GetApplicationEventTarget(), { (_, _, userData) -> OSStatus in
            let controller = Unmanaged<StatusBarController>.fromOpaque(userData!).takeUnretainedValue()
            controller.togglePanel()
            return noErr
        }, 1, &eventType, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
        
        // Register the hotkey (Cmd+Shift+V)
        // Virtual key 9 is 'V', modifiers cmdKey + shiftKey
        RegisterEventHotKey(9, UInt32(cmdKey | shiftKey), hotKeyID, GetApplicationEventTarget(), 0, &hotKeyRef)
    }
}
