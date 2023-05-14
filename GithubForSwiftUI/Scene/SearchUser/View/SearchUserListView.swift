//
//  SearchUserListView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI

extension SearchUserScreenView {
    struct SearchUserListView<State: SearchUserStateProtocol>: View {
        @ObservedObject var state: State
        
        var body: some View {
            switch state.items.isEmpty {
            case false:
                ScrollView(showsIndicators: true) {
                    LazyVGrid(columns: [.init()], alignment: .leading, spacing: 8.0) {
                        ForEach(state.items, id: \.id) { item in
                            NavigationLink {
                                UserDetailScreenView(
                                    interactor: .init(
                                        repository: UserDetailRepositoryImpl(),
                                        state: .init(userName: item.name)
                                    )
                                )
                            } label: {
                                SearchUserDetailView(state: item)
                            }
                        }
                    }
                }
            case true:
                Text("見つかりませんでした。\n別のキーワードで検索してください。")
            }
        }
    }
}

private struct SearchUserDetailView<State: SearchUserDetailStateProtocol>: View {
    @ObservedObject var state: State
    
    var body: some View {
        HStack(alignment: .center, spacing: 12.0) {
            AsyncImage(url: state.profileImage) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50.0, height: 50.0)
            
            Text(state.name)
                .foregroundColor(Color.black)
                .font(.system(size: 24.0).bold())
            
            Spacer()
        }
        .background(Color.white)
        .border(.gray, width: 2.0)
    }
}

#if DEBUG
struct SearchUserListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserScreenView.SearchUserListView(state: SearchUserState())
    }
}
#endif
