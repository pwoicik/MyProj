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
                        ForEach(groups) { group in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(group.name)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .background(Material.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 5,
                                    y: 5
                                )
                                HStack {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color(UIColor.systemRed).opacity(0.7))
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
                            .padding(.horizontal)
                        }
                        Spacer(minLength: 64)
                    }
                    .animation(.default, value: groups)
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HStack {
                Text("Your groups")
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .padding(.bottom, 40)
            .background(
                Color(UIColor.systemBackground)
                    .blur(radius: 20)
            )
        }
    }
}

struct SavedItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemsScreen()
    }
}
