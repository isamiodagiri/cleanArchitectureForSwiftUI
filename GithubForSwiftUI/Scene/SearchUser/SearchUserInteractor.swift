//
//  SearchUserInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

@MainActor
struct SearchUserInteractor<Repository: SearchUserRepository> {
    var state: some SearchUserStateProtocol {
        stateImpl
    }
    
    func onAppear() async {
        await updateUI()
    }
    
    func onSubmitSearch() async {
        await updateUI(query: stateImpl.keyWordPublished)
    }
    
    func onSearchableText(_ keyWord: String) {
        stateImpl.keyWordPublished = keyWord
    }
    
    private var repository: Repository
    private var stateImpl: SearchUserState
    
    init(repository: Repository, state: SearchUserState = .init()) {
        self.repository = repository
        self.stateImpl = state
    }
}
// MARK: - Private
extension SearchUserInteractor {
    private func updateUI(query: String = "swift") async {
        do {
            let items = try await repository.fetchUserList(query: query)
            stateImpl.itemsPublished = items
        } catch {
            // エラー処理
            print(error)
        }
    }
}
