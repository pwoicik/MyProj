//
//  ScheduleViewModel.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Combine
import Foundation
import SwiftDate
import OrderedCollections

class ScheduleViewModel: ObservableObject {

    let group: GroupModel

    @Published
    private(set) var isSaved: Bool? = nil

    private var schedule: NetworkResult<ScheduleModel>? = nil

    @Published
    private(set) var classesByDate: NetworkResult<OrderedDictionary<Date, [ClassModel]>>? = nil

    let timeAtInit = Date()
    @Published
    private(set) var currentTime = Date()

    init(group: GroupModel) {
        self.group = group
        initTimeTask()
        Task {
            self.schedule = await Repository.getSchedule(id: group.id)
            let classesByDate = self.schedule?.map { schedule in
                OrderedDictionary(grouping: schedule.classes) { klass in
                    klass.startDate.dateAt(.startOfDay)
                }
            }
            await MainActor.run {
                self.classesByDate = classesByDate
            }
        }
        ScheduleDao.isGroupSaved(id: group.id)
            .map { $0 as Bool? }
            .assign(to: &$isSaved)
    }

    func emit(_ event: ScheduleScreenEvent) {
        switch event {
        case .onToggleSavedState:
            if isSaved == true {
                ScheduleDao.deleteGroup(group: group)
            } else if isSaved == false {
                ScheduleDao.saveGroup(group: group)
            }
        }
    }

    private var timeTask: Task<Void, Never>?
    private func initTimeTask() {
        timeTask = Task { [unowned self] in
            while !Task.isCancelled {
                let now = Date.now
                DispatchQueue.main.async {
                    self.currentTime = now
                }
                try? await Task.sleep(
                    until: .now + .seconds(60 - now.second),
                    tolerance: SuspendingClock.Duration.seconds(1),
                    clock: .suspending
                )
            }
        }
    }

    deinit {
        timeTask?.cancel()
    }
}

enum ScheduleScreenEvent {
    case onToggleSavedState
}
