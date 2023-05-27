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

#if DEBUG
struct UserDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailScreenView(interactor: .init(repository: UserDetailRepositoryImpl(), state: .init()))
    }
}
#endif
