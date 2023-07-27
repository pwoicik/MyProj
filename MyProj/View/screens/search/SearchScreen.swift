import Foundation
import SwiftUI

struct SearchScreen: View {

    @StateObject
    var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            switch viewModel.filteredGroups {
            case nil:
                ProgressView()
            case let .failure(error):
                Text(error.localizedDescription)
            case let .success(groups):
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(groups) { group in
                            NavigationLink(value: group) {
                                HStack {
                                    Text(group.name)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .frame(minHeight: 44)
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal, 12)
                            Divider()
                                .frame(width: 64)
                        }
                        Spacer(minLength: 64)
                    }
                }.safeAreaInset(edge: .top) { search }
            }
        }
    }

    @FocusState
    var isFocused

    var search: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.secondary)
            TextField(
                text: Binding(
                    get: { viewModel.query },
                    set: { viewModel.emit(.queryChange($0)) }
                ),
                label: { Text("Search") }
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .focused($isFocused)
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.secondary)
                .scaleEffect(viewModel.query.isEmpty ? 0 : 1)
                .opacity(viewModel.query.isEmpty ? 0 : 1)
                .animation(.spring(blendDuration: 0), value: viewModel.query.isEmpty)
                .onTapGesture {
                    viewModel.emit(.searchCancelled)
                }
        }
        .padding([.horizontal, .bottom])
        .padding(.top, 4)
        .background(Material.bar)
        .onTapGesture { isFocused = true }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
