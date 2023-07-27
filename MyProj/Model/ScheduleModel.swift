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
