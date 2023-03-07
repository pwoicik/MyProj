//
//  SavedItemsScreen.swift
//  MyProj
//
//  Created by Patryk Wójcik on 06/03/2023.
//

import SwiftUI

struct SavedItemsScreen: View {

    @StateObject
    var viewModel = SavedItemsViewModel()

    var body: some View {
        VStack {
            switch viewModel.groups {
            case .none:
                ProgressView()
            case let .some(groups):
                ScrollView {
                    LazyVStack(spacing: 24) {
                        Spacer(minLength: 20)
                        ForEach(groups) { group in
                            itemCard(group)
                                .padding(.horizontal)
                        }
                        Spacer(minLength: 64)
                    }
                    .animation(.default, value: groups)
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            topBar
        }
    }

    private var topBar: some View {
        HStack {
            Text("Your groups")
                .font(.title)
            Spacer()
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .background(
            Color.background
                .ignoresSafeArea()
                .shadow(color: .background, radius: 15, y: 10)
        )
    }

    private func itemCard(_ group: GroupModel) -> some View {
        VStack(spacing: 0) {
            NavigationLink(value: group) {
                HStack {
                    Text(group.name)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
            }
            .background(Material.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(
                color: .black.opacity(0.3),
                radius: 5,
                y: 5
            )
            HStack {
                Image(systemName: "trash")
                    .foregroundColor(.red.opacity(0.7))
                    .onTapGesture {
                        viewModel.emit(.onGroupDelete(group))
                    }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 14)
        }
        .background(Material.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct SavedItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemsScreen()
    }
}
