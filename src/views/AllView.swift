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
                    Text(entry.timestamp.formatted(date: .omitted, time: .shortened))
                        .monospaced()
                    Text(entry.message)
                    Spacer()
                }
            }

            Spacer()
        }
        .padding([.leading, .trailing], 100)
    }
}
