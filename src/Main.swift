import SwiftData
import SwiftUI

@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .toolbarBackgroundVisibility(.hidden)
                .toolbar(removing: .title)
        }
        .modelContainer(for: LogEntry.self)
    }
}
