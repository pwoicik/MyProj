import Foundation
import GRDB

extension ClassModel: TableRecord {
    static var databaseTableName = "class"

    enum Columns: String, ColumnExpression {
        case id
        case name
        case type
        case startDate
        case endDate
    }

}

extension ClassModel: FetchableRecord {
    init(row: Row) {
        id = row[Columns.id]
        name = row[Columns.name]
        type = row[Columns.type]
        startDate = row[Columns.startDate]
        endDate = row[Columns.endDate]
    }
}

extension ClassModel: PersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.name] = name
        container[Columns.type] = type
        container[Columns.startDate] = startDate
        container[Columns.endDate] = endDate
    }
}
