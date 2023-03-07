import Foundation
import GRDB

class ScheduleDb {
    private init() { }

    // swiftlint:disable force_try
    static let db = {
        let databaseURL = try! FileManager.default
            .url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent("db.sqlite")
        let db = try! DatabaseQueue(path: databaseURL.path)
        try? db.write { db in
            try db.create(table: "groups") { t in
                t.primaryKey("id", .text)
                t.column("name", .text).notNull()
            }
        }
        return db
    }()
}
