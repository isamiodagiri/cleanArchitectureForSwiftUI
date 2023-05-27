//
//  UserDetailScreenView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI

struct UserDetailScreenView: View {
    var interactor: UserDetailInteractor<UserDetailRepositoryImpl>

    var body: some View {
        UserDetailContentsView(state: interactor.state)
            .navigationTitle("ユーザー詳細")
            .onAppear(perform: interactor.onAppear)
    }
}

private extension UserDetailScreenView {
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
    
    struct UserDetailRepositoryListView<State: UserDetailRepositoryListStateProtocol>: View {
        @ObservedObject var state: State
        
        var body: some View {
            VStack {
                Text("RepositoryList")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4.0)
                    .padding(.leading, 8.0)
                    .background(Color.gray.opacity(0.5))
                
                LazyVGrid(columns: [.init()], alignment: .leading, spacing: 8.0) {
                    ForEach(state.items, id: \.id) { item in
                        UserDetailRepositoryDetailView(state: item)
                            .padding(.horizontal, 8.0)
                    }
                }
            }
        }
    }
    
    struct UserDetailRepositoryDetailView<State: UserDetailRepositoryDetailStateProtocol>: View {
        @ObservedObject var state: State
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(state.name)
                    .lineLimit(1)
                
                Text(state.fullName)
                    .lineLimit(1)
                
                Text(state.description ?? "")
                    .lineLimit(2)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        WebView(loadUrl: state.url)
                    } label: {
                        Text("詳細を見る")
                    }
                }
            }
            .padding(.all, 8.0)
            .border(.gray, width: 2.0)
        }
    }
}

#if DEBUG
struct UserDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailScreenView(interactor: .init(repository: UserDetailRepositoryImpl(), state: .init()))
    }
}
#endif
