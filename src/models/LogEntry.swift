import Foundation
import SwiftData

@Model
class LogEntry: Identifiable {
    var timestamp: Date
    var message: String

    init(timestamp: Date, message: String) {
        self.timestamp = timestamp
        self.message = message
    }
}
