//
//  UserDetailInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

@MainActor
struct UserDetailInteractor<Repository: UserDetailRepository> {
    var state: some UserDetailStateProtocol {
        stateImpl
    }

    func onAppear() async {
        await updateUI(with: stateImpl.userName)
    }
    
    private var repository: Repository
    private var stateImpl: UserDetailState

    init(repository: Repository, state: UserDetailState) {
        self.repository = repository
        self.stateImpl = state
    }
}
// MARK: - Private
extension UserDetailInteractor {
    private func updateUI(with name: String) async {
        do {
            let headerResult = try await repository.fetchUser(with: name)
            let repositoryListResult = try await repository.fetchRepository(with: name)
            stateImpl.headerPublished = headerResult
            stateImpl.repositoryListPublished = repositoryListResult
        } catch {
            // エラー処理
            print(error)
        }
    }
}
