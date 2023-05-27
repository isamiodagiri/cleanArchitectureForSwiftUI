//
//  SearchUserScreenView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI

struct SearchUserScreenView: View {
    var interactor: SearchUserInteractor<SearchUserRepositoryImpl>
    
    var body: some View {
        NavigationView {
            SearchUserListView(state: interactor.state)
                .padding(.horizontal, 16.0)
                .padding(.vertical, 20.0)
                .navigationTitle("ユーザー一覧")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: Binding(get: {
                        interactor.state.keyWord
                    }, set: {
                        interactor.onSearchableText($0)
                    }),
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("キーワードを入力してください")
                )
                .onSubmit(of: .search, interactor.onSubmitSearch)
        }
        .onAppear(perform: interactor.onAppear)
    }
}


private extension SearchUserScreenView {
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
    
    struct SearchUserDetailView<State: SearchUserDetailStateProtocol>: View {
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
}

#if DEBUG
struct SearchUserScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserScreenView(interactor: .init(repository: SearchUserRepositoryImpl()))
    }
}
#endif
