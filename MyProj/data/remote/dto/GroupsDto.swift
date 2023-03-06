//
//  GroupsDto.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Foundation

struct GroupsDto: Codable {
    let groups: [GroupDto]

    enum CodingKeys: String, CodingKey {
        case groups = "zasob"
    }
}

struct GroupDto: Codable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "nazwa"
    }
}
