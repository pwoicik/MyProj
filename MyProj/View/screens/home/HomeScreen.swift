import SwiftUI
import Combine

class HomeVM: ObservableObject {
    
    @Published
    var schedules: [ScheduleModel]? = []
    
    init() {
        ScheduleDao.getSavedGroups()
//            .map(KeyPath<[GroupModel], T>)
    }
    
}

struct HomeScreen: View {

    @StateObject
    var vm = HomeVM()

    var body: some View {
        Text("Hello, World!")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
