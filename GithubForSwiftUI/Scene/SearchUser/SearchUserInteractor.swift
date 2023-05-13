//
//  SearchUserInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class SearchUserInteractor: ObservableObject {
    var state: SearchUserState
    
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
    
    init(state: SearchUserState = .init()) {
        self.state = state
    }
    
    @MainActor
    private func updateUI(query: String = "swift") async {
        do {
            let items = try await fetchUserList(query: query)
            state.itemsPublished = items
        } catch {
            print(error)
        }
    }
    
    private func fetchUserList(query: String) async throws -> [SearchUserDetailState] {
        let session = Session()
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil)
        
        do {
            let result = try await session.send(request)
            return result?.items.map {
                .init(id: "\($0.id)", name: $0.login, profileImage: $0.avatarURL)
            } ?? []
        } catch {
            throw error
        }
    }
}
