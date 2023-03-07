import SwiftUI

enum HomeScreenTab: Hashable {
    case schedule
    case savedItems
    case searchScreen
}

struct ContentView: View {

    @State
    var selectedTab: HomeScreenTab = .searchScreen

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ProgressView()
                    .tag(HomeScreenTab.schedule)
                    .tabItem {
                        Label(
                            "Schedule",
                            systemImage: "calendar"
                        )
                    }
                SavedItemsScreen()
                    .tag(HomeScreenTab.savedItems)
                    .tabItem {
                        Label(
                            "Saved",
                            systemImage: "folder"
                        )
                    }
                SearchScreen()
                    .tag(HomeScreenTab.searchScreen)
                    .tabItem {
                        Label(
                            "Search",
                            systemImage: "magnifyingglass"
                        )
                    }
            }
            .navigationDestination(
                for: GroupModel.self,
                destination: ScheduleScreen.init
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
