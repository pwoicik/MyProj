//
//  ScheduleDto.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Foundation

struct ScheduleDto: Codable {
    let id: String
    let name: String
    let classes: [ClassDto]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nazwa"
        case classes = "zajecia"
    }
}

struct ClassDto: Codable {
    let date: String
    let startTime: String
    let endTime: String
    let name: String
    let type: String
    let teacher: TeacherDto?
    let location: String
    let note: String?

    enum CodingKeys: String, CodingKey {
        case date = "termin"
        case startTime = "od-godz"
        case endTime = "do-godz"
        case name = "przedmiot"
        case type = "typ"
        case teacher = "nauczyciel"
        case location = "sala"
        case note = "uwagi"
    }
}

struct TeacherDto: Codable {
    let name: String
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name = ""
        case id = "moodle"
    }
}
