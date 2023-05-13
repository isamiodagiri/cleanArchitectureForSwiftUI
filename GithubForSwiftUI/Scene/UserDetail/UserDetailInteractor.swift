//
//  UserDetailInteractor.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

class UserDetailInteractor: ObservableObject {
    var state: UserDetailState
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
        Task { [weak self] in
            await self?.updateUI(with: self?.state.userName ?? "")
        }
    }
    
    init(state: UserDetailState) {
        self.state = state
    }
    
    @MainActor
    private func updateUI(with name: String) async {
        do {
            let headerResult = try await fetchUser(with: name)
            let repositoryListResult = try await fetchRepository(with: name)
            state.headerPublished = headerResult
            state.repositoryListPublished = repositoryListResult
        } catch {
            // エラー処理
            print(error)
        }
    }
    
    private func fetchUser(with name: String) async throws -> UserDetailHeaderState {
        let session = Session()
        let request = UserDetailRequest(userName: name)
        
        do {
            guard let result = try await session.send(request) else {
                throw NSError(domain: "error", code: 1)
            }

            return .init(id: "\(result.id)", name: result.login, profileImage: result.avatarURL, followers: result.followers, following: result.following)
        } catch {
            throw error
        }
    }
    
    private func fetchRepository(with name: String) async throws -> UserDetailRepositoryListState  {
        let session = Session()
        let request = UserRepositoryRequest(userName: name)
        
        do {
            let result = try await session.send(request)
            let items: [UserDetailRepositoryDetailState] = result?.map {
                .init(id: "\($0.id)", name: $0.name, fullName: $0.fullName, description: $0.description, url: $0.htmlURL, fork: $0.fork)
            } ?? []
            
            return .init(items: items)
        } catch {
            throw error

        }
    }
}
