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
    }

    func emit(_ event: SearchScreenEvent) {
        switch event {
        case let .queryChange(newQuery):
            onQueryChange(newQuery)
        case .searchCancelled:
            onSearchCancelled()
        }
    }

    private var queryTask: Task<Void, Never>? = nil
    private func onQueryChange(_ newQuery: String) {
        if query == newQuery {
            return
        }
        query = newQuery
        queryTask?.cancel()
        queryTask = Task(priority: .userInitiated) {
            try? await Task.sleep(for: .milliseconds(300))
            if Task.isCancelled {
                return
            }
            if newQuery.isEmpty {
                await MainActor.run {
                    self.filteredGroups = self.groups
                }
                return
            }
            let filteredGroups = self.groups?.map { groups in
                groups.filter { group in
                    group.name.contains(newQuery, ignoreCase: true)
                }
            }
            await MainActor.run {
                self.filteredGroups = filteredGroups
            }
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
