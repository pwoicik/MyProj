import Foundation

class ScheduleService {
    private init() { }

    static func getGroups() async -> NetworkResult<GroupsDto> {
        await ScheduleApi.get(
            url("typ=G")
        )
    }

    static func getSchedule(id: String) async -> NetworkResult<ScheduleDto> {
        await ScheduleApi.get(
            url("typ=G&id=\(id)&okres=2")
        )
    }

    private static func url(_ query: String) -> String {
        "https://planzajec.uek.krakow.pl/index.php?\(query)&xml"
    }
}
