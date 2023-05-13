//
//  SearchUserScreenView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI

struct SearchUserScreenView: View {
    @StateObject var interactor: SearchUserInteractor
    
    var body: some View {
        NavigationView {
            SearchUserListView(state: interactor.state)
                .padding(.horizontal, 16.0)
                .padding(.vertical, 20.0)
                .navigationTitle("ユーザー一覧")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: $interactor.state.keyWordPublished,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("キーワードを入力してください")
                )
                .onSubmit(of: .search, interactor.onSubmitSearch)
        }
        .onAppear(perform: interactor.onAppear)
    }
}

#if DEBUG
struct SearchUserScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserScreenView(interactor: .init())
    }
}
#endif
