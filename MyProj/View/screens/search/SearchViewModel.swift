import Combine
import Foundation

class SearchViewModel: ObservableObject {

    private var groups: NetworkResult<[GroupModel]>? = nil

    @Published
    private(set) var filteredGroups: NetworkResult<[GroupModel]>? = nil

    @Published
    private(set) var query = ""

    init() {
        Task(priority: .userInitiated) {
            let groups = await Repository.getGroups()
            await MainActor.run {
                self.groups = groups
                self.filteredGroups = groups
            }
        }

        $query
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global(qos: .userInitiated))
            .map { query in
                if query.isEmpty {
                    return self.groups
                }
                return self.groups?.map { groups in
                    groups.filter { group in
                        group.name.contains(query, ignoreCase: true)
                    }
                }
            }
            .subscribe(on: DispatchQueue.main)
            .assign(to: &$filteredGroups)
    }

    func emit(_ event: SearchScreenEvent) {
        switch event {
        case let .queryChange(query):
            self.query = query
        case .searchCancelled:
            onSearchCancelled()
        }
    }

    private func onSearchCancelled() {
        query = ""
        filteredGroups = groups!
    }
}

enum SearchScreenEvent {
    case queryChange(String)
    case searchCancelled
}
