import Foundation
import SwiftData
import SwiftUI

struct LogWriteView: View {
    @Binding var showInput: Bool
    @FocusState var focused: Bool
    @State private var message: String = ""

    var onSubmit: (LogEntry) -> Void

    var body: some View {
        HStack {
            Text(Date().formatted(date: .omitted, time: .shortened))
                .monospaced()
            TextField("message", text: $message)
                .textFieldStyle(.plain)
                .onSubmit {
                    if !message.isEmpty {
                        onSubmit(LogEntry(timestamp: Date(), message: message))
                    }
                    message = ""
                    showInput = false
                }
                .focused($focused)
                .onAppear {
                    focused = showInput
                }
                .onExitCommand(perform: {
                    if showInput {
                        showInput = false
                    }
                })
        }
    }
}

struct TodayView: View {
    static var today = Calendar.current.startOfDay(for: Date())
    @Environment(\.modelContext) var modelContext
    @Query(
        filter: #Predicate<LogEntry> {
            $0.timestamp > today
        }, sort: \LogEntry.timestamp) private var entries: [LogEntry]
    @State private var showInput: Bool = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star.fill")
                    .symbolRenderingMode(.multicolor)
                Text("Today")
                Spacer()
            }.font(.largeTitle)

            Divider()

            ForEach(entries, id: \.self) { entry in
                HStack {
                    Text(entry.timestamp.formatted(date: .omitted, time: .shortened))
                        .monospaced()
                    Text(entry.message)
                    Spacer()
                }
            }

            if showInput {
                LogWriteView(
                    showInput: $showInput,
                    onSubmit: { logEntry in
                        modelContext.insert(logEntry)
                    })
            }

            Spacer()
        }
        .padding([.leading, .trailing], 100)
        .toolbar(content: {
            ToolbarItem {
                Button("Add", systemImage: "plus") {
                    print("Add pressed")
                    showInput = true
                }
                .labelStyle(.iconOnly)
                .keyboardShortcut("n", modifiers: .command)
            }
        })
    }
}
