import SwiftUI

struct LogEntryTimeView: View {
    var date: Date

    var body: some View {
        Text(
            date.formatted(
                Date.FormatStyle().hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits))
        ).monospaced()
    }
}
