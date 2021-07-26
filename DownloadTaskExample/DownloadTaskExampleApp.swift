import os
import SwiftUI

@main
struct DownloadTaskExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                DownloadQueueView()
            }
        }
    }
}

class DownloadBackgroundMessages: ObservableObject {
    @AppStorage("DownloadManagerMessages") var messages: String?

    public static let shared = DownloadBackgroundMessages()

    private init() {}
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        // When a download is completed with the app process not launched
        // The app is activated in background to handle it
        // This is the only chance to get notified about the completed download
        // Just as an example / to make this visible, a UserDefault is written
        // here so we can see this notification actually happen

        DownloadBackgroundMessages.shared.messages = ((DownloadBackgroundMessages.shared.messages ?? "") + "\n" + "Received a handleEventsForBackgroundURLSession call").trimmingCharacters(in: .whitespacesAndNewlines)

        os_log("handleEventsForBackgroundURLSession for %@", type: .info, identifier)

        completionHandler()
    }
    
}
