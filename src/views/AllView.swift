import SwiftData
import SwiftUI

struct AllView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \LogEntry.timestamp) private var entries: [LogEntry]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "text.book.closed.fill")
                    .symbolRenderingMode(.multicolor)
                Text("All time")
                Spacer()
            }.font(.largeTitle)

            Divider()

            ForEach(entries) { entry in
                HStack {
                    LogEntryTimeView(date: entry.timestamp)
                    Text(entry.message)
                    Spacer()
                }
            }

            Spacer()
        }
        .padding([.leading, .trailing], 100)
    }
}
