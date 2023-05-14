//
//  SearchUserInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class SearchUserInteractor<Repository: SearchUserRepository>: ObservableObject {
    var state: SearchUserState
    var repository: Repository
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI()
        }
    }
    
    private(set) lazy var onSubmitSearch: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI(query: self?.state.keyWordPublished ?? "")
        }
    }
    
    init(repository: Repository, state: SearchUserState = .init()) {
        self.repository = repository
        self.state = state
    }
    
    @MainActor
    private func updateUI(query: String = "swift") async {
        do {
            let items = try await repository.fetchUserList(query: query)
            state.itemsPublished = items
        } catch {
            print(error)
        }
    }    
}
