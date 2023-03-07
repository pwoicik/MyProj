//
//  ScheduleDao.swift
//  MyProj
//
//  Created by Patryk Wójcik on 06/03/2023.
//

import Combine
import Foundation
import GRDB

class ScheduleDao {
    private init() { }

    static func saveGroup(group: GroupModel) {
        try? ScheduleDb.db.write { db in
            try group.insert(db, onConflict: .ignore)
        }
    }

    static func deleteGroup(group: GroupModel) {
        _ = try? ScheduleDb.db.write { db in
            try group.delete(db)
        }
    }

    static func getSavedGroups() -> AnyPublisher<[GroupModel], Never> {
        ValueObservation
            .tracking { db in
                try GroupModel.fetchAll(db)
            }
            .publisher(in: ScheduleDb.db)
            .mapError { _ in Never.transferRepresentation }
            .eraseToAnyPublisher()
    }

    static func isGroupSaved(id: String) -> AnyPublisher<Bool, Never> {
        ValueObservation.tracking { db in
            let group = try? GroupModel.fetchOne(
                db,
                sql: "SELECT * FROM groups WHERE id = :id",
                arguments: ["id": id]
            )
            return group != nil
        }
        .publisher(in: ScheduleDb.db)
        .mapError { _ in Never.transferRepresentation }
        .eraseToAnyPublisher()
    }
}
