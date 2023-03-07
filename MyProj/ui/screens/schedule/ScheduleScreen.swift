import SwiftDate
import SwiftUI

struct ScheduleScreen: View {

    @StateObject
    var viewModel: ScheduleViewModel

    @Environment(\.dismiss)
    var dismiss

    init(group: GroupModel) {
        _viewModel = StateObject(
            wrappedValue: ScheduleViewModel(group: group)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            switch viewModel.classesByDate {
            case nil:
                ProgressView()
            case let .failure(error):
                Text(error.localizedDescription)
            case let .success(classesByDate):
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(
                            alignment: .leading,
                            spacing: 0,
                            pinnedViews: [.sectionHeaders]
                        ) {
                            ForEach(
                                classesByDate.elements,
                                id: \.key.date,
                                content: classSection
                            )
                        }
                        .onAppear {
                            guard let scrollTo = (
                                classesByDate.keys
                                    .first { $0 >= viewModel.timeAtInit }
                                    ?? classesByDate.keys.last
                            ) else {
                                return
                            }
                            proxy.scrollTo(scrollTo)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) { topBar }
    }

    private var topBar: some View {
        HStack {
            Text(viewModel.group.name)
            Spacer()
            Group {
                switch viewModel.isSaved {
                case .none:
                    EmptyView()
                case let .some(isSaved):
                    Image(systemName: isSaved ? "minus.diamond" : "plus.app")
                        .foregroundColor(isSaved ? .red : .accentColor)
                        .rotationEffect(.degrees(isSaved ? 180 : 0))
                        .animation(.default, value: isSaved)
                        .onTapGesture {
                            viewModel.emit(.onToggleSavedState)
                        }
                }
            }
            .font(.title2)
            .frame(width: 44, height: 44)
        }
        .padding(.leading, 12)
        .padding(.bottom, 8)
        .background(Color.background)
    }

    private func classSection(date: Date, classes: [ClassModel]) -> some View {
        Section(header: dateHeader(date)) {
            ForEach(
                classes,
                id: \.hashValue,
                content: {
                    ClassView(klass: $0, time: viewModel.currentTime)
                }
            )
        }
    }

    private func dateHeader(_ date: Date) -> some View {
        HStack {
            Text(
                date.in(region: .current).toFormat(
                    "dd MMM yyyy",
                    locale: Locales.current
                )
            )
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(Material.regular)
    }
}

struct ScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen(
            group: GroupModel(id: "0", name: "Group no. 1")
        )
    }
}

enum ClassState {
    case future
    case ongoing
    case past
}

struct ClassView: View {

    let klass: ClassModel
    let state: ClassState

    init(klass: ClassModel, time: Date) {
        self.klass = klass

        if klass.startDate > time {
            state = .future
        } else if klass.endDate < time {
            state = .past
        } else {
            state = .ongoing
        }
    }

    private func dateToTimeString(_ date: Date) -> String {
        date.in(region: .current).toFormat("H:mm")
    }

    var body: some View {
        HStack(
            alignment: .top,
            spacing: 24
        ) {
            VStack(
                alignment: .trailing,
                spacing: 8
            ) {
                Text(dateToTimeString(klass.startDate))
                    .foregroundColor(
                        state == .ongoing
                            ? .brown
                            : state == .future
                                ? .primary
                                : .secondary
                    )
                Text(dateToTimeString(klass.endDate))
                    .foregroundColor(
                        state == .ongoing
                            ? .green
                            : state == .future
                                ? .primary
                                : .secondary
                    )
                    .fontWeight(state == .ongoing ? .medium : .regular)
            }
            .font(.callout)
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text(klass.name)
                    .font(.body)
                Text(klass.type)
                    .font(.caption)
            }
        }
        .padding()
    }
}

struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date()
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-ongoing")
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date() + 1.days
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-past")
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date() - 1.days
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-future")
    }
}
