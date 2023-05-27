//
//  UserDetailInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class UserDetailInteractor<Repository: UserDetailRepository>: ObservableObject {
    private(set) lazy var state: some UserDetailStateProtocol = {
        stateImpl
    }()

    private(set) lazy var onAppear: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI(with: self?.stateImpl.userName ?? "")
        }
    }
    
    private var repository: Repository
    private var stateImpl: UserDetailState

    init(repository: Repository, state: UserDetailState) {
        self.repository = repository
        self.stateImpl = state
    }
    
    @MainActor
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
