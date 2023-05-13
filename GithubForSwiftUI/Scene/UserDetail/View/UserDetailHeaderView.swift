//
//  UserDetailHeaderView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/13.
//

import SwiftUI

extension UserDetailScreenView {
    struct UserDetailHeaderView<State: UserDetailHeaderStateProtocol>: View {
        @ObservedObject var state: State

        var body: some View {
            HStack(spacing: 16.0) {
                AsyncImage(url: state.profileImage) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150.0)
                .cornerRadius(6.0)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 1.0) {
                        Text("UserName:")
                        Text(state.name)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 1.0) {
                        Text("followers:")
                        Text("\(state.followers)")
                    }
                    HStack(spacing: 1.0) {
                        Text("following:")
                        Text("\(state.following)")
                    }
                }
                .padding(.vertical, 16.0)
            }
            .frame(height: 150.0)
        }
    }
}
