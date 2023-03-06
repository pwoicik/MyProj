//
//  GroupEntity.swift
//  MyProj
//
//  Created by Patryk Wójcik on 06/03/2023.
//

import Foundation
import GRDB

extension GroupModel: TableRecord {
    static var databaseTableName = "groups"

    enum Columns: String, ColumnExpression {
        case id
        case name
    }
}

extension GroupModel: FetchableRecord {
    init(row: Row) {
        id = row[Columns.id]
        name = row[Columns.name]
    }
}

extension GroupModel: PersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.name] = name
    }
}
