//
//  SearchUserInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class SearchUserInteractor<Repository: SearchUserRepository> {
    private(set) lazy var state: some SearchUserStateProtocol = {
        stateImpl
    }()
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI()
        }
    }
    
    private(set) lazy var onSubmitSearch: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI(query: self?.stateImpl.keyWordPublished ?? "")
        }
    }
    
    private(set) lazy var onSearchableText: (String) -> Void = { [weak self] in
        self?.stateImpl.keyWordPublished = $0
    }
    
    private var repository: Repository
    private var stateImpl: SearchUserState
    
    init(repository: Repository, state: SearchUserState = .init()) {
        self.repository = repository
        self.stateImpl = state
    }
    
    @MainActor
    private func updateUI(query: String = "swift") async {
        do {
            let items = try await repository.fetchUserList(query: query)
            stateImpl.itemsPublished = items
        } catch {
            print(error)
        }
    }    
}
