//
//  Repository.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Foundation
import SwiftDate

class Repository {
    private init() { }

    static func getGroups() async -> NetworkResult<[GroupModel]> {
        await ScheduleService.getGroups().map {
            $0.groups.map {
                GroupModel(id: $0.id, name: $0.name)
            }
        }
    }

    static func getSchedule(id: String) async -> NetworkResult<ScheduleModel> {
        await ScheduleService.getSchedule(id: id).map {
            ScheduleModel(
                group: GroupModel(id: $0.id, name: $0.name),
                classes: $0.classes.map {
                    ClassModel(
                        name: $0.name.nilIfEmpty() ?? $0.type,
                        type: $0.type,
                        startDate: Date(
                            $0.date + " " + $0.startTime,
                            format: "yyyy-MM-dd HH:mm",
                            region: Region(zone: Zones.europeWarsaw)
                        )!,
                        endDate: Date(
                            $0.date + " " + $0.endTime.take(5),
                            format: "yyyy-MM-dd HH:mm",
                            region: Region(zone: Zones.europeWarsaw)
                        )!
                    )
                }
            )
        }
    }
}
