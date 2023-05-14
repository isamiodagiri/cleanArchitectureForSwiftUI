//
//  UserDetailInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class UserDetailInteractor<Repository: UserDetailRepository>: ObservableObject {
    var state: UserDetailState
    var repository: Repository

    private(set) lazy var onAppear: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI(with: self?.state.userName ?? "")
        }
    }
    
    init(repository: Repository, state: UserDetailState) {
        self.repository = repository
        self.state = state
    }
    
    @MainActor
    private func updateUI(with name: String) async {
        do {
            let headerResult = try await repository.fetchUser(with: name)
            let repositoryListResult = try await repository.fetchRepository(with: name)
            state.headerPublished = headerResult
            state.repositoryListPublished = repositoryListResult
        } catch {
            // エラー処理
            print(error)
        }
    }
}
