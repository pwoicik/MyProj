//
//  ScheduleModel.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Foundation

struct ScheduleModel {
    let group: GroupModel
    let classes: [ClassModel]
}

struct ClassModel: Hashable {
    let name: String
    let type: String
    let startDate: Date
    let endDate: Date
}
