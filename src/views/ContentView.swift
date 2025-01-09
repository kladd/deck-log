import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TabSection {
                Tab("Today", systemImage: "star.fill") {
                    TodayView()
                }
                Tab("All time", systemImage: "text.book.closed.fill") {
                    AllView()
                }
            }
            TabSection {
                Tab("Trash", systemImage: "trash.fill") {
                    Text("404")
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .symbolRenderingMode(.hierarchical)
    }
}

#Preview {
    ContentView()
}
