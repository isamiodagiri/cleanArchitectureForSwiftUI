//
//  UserDetailContentsView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/13.
//

import SwiftUI

extension UserDetailScreenView {
    struct UserDetailContentsView<State: UserDetailStateProtocol>: View {
        @ObservedObject var state: State

        var body: some View {
            ScrollView {
                VStack {
                    UserDetailHeaderView(state: state.header)

                    UserDetailRepositoryListView(state: state.repositoryList)
                }
            }
        }
    }
}
