import Foundation

struct ScheduleModel {
    let group: GroupModel
    let classes: [ClassModel]
}

struct ClassModel: Hashable {
    internal init(id: Int = 0, name: String, type: String, startDate: Date, endDate: Date) {
        self.id = id
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
    }
    
    let id: Int
    let name: String
    let type: String
    let startDate: Date
    let endDate: Date
}
