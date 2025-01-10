import Foundation
import SwiftData

typealias LogEntry = LogEntryV2

@Model
class LogEntryV1: Identifiable {
    var timestamp: Date
    var message: String

    init(timestamp: Date, message: String) {
        self.timestamp = timestamp
        self.message = message
    }
}

@Model
class LogEntryV2: Identifiable {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var message: String

    init(timestamp: Date, message: String) {
        self.id = UUID()
        self.timestamp = timestamp
        self.message = message
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum LogEntrySchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] = [LogEntryV1.self]
}

enum LogEntrySchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] = [LogEntryV2.self]
}

enum LogEntryMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [LogEntrySchemaV1.self, LogEntrySchemaV2.self]

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: LogEntrySchemaV1.self,
        toVersion: LogEntrySchemaV2.self,
        willMigrate: { context in
            let descriptor = FetchDescriptor<LogEntryV1>()
            let oldEntries = try context.fetch(descriptor)

            for oldEntry in oldEntries {
                let newEntry = LogEntryV2(
                    timestamp: oldEntry.timestamp,
                    message: oldEntry.message
                )
                context.insert(newEntry)
            }

            for oldEntry in oldEntries {
                context.delete(oldEntry)
            }

            try context.save()
        },
        didMigrate: nil
    )
}
