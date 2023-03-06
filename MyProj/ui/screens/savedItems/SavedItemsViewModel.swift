//
//  SavedItemsViewModel.swift
//  MyProj
//
//  Created by Patryk Wójcik on 06/03/2023.
//

import Foundation

class SavedItemsViewModel: ObservableObject {

    @Published
    private(set) var groups: [GroupModel]? = nil

    init() {
        ScheduleDao.getSavedGroups()
            .map { .some($0) }
            .assign(to: &$groups)
    }

    func emit(_ event: SavedItemsEvent) {
        switch event {
        case let .onGroupDelete(group):
            ScheduleDao.deleteGroup(group: group)
        }
    }
}

enum SavedItemsEvent {
    case onGroupDelete(GroupModel)
}
