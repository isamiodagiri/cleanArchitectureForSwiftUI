//
//  UserDetailRepository.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/14.
//

import Foundation

protocol UserDetailRepository {
    func fetchUser(with name: String) async throws -> UserDetailHeaderState
    func fetchRepository(with name: String) async throws -> UserDetailRepositoryListState
}

struct UserDetailRepositoryImpl: UserDetailRepository {
    func fetchUser(with name: String) async throws -> UserDetailHeaderState {
        let session = Session()
        let request = UserDetailRequest(userName: name)
        
        guard let result = try await session.send(request) else {
            throw NSError(domain: "error", code: 1)
        }
        
        return .init(id: "\(result.id)", name: result.login, profileImage: result.avatarURL, followers: result.followers, following: result.following)
        
    }
    
    func fetchRepository(with name: String) async throws -> UserDetailRepositoryListState  {
        let session = Session()
        let request = UserRepositoryRequest(userName: name)
        
        let result = try await session.send(request)
        let items: [UserDetailRepositoryDetailState] = result?.map {
            .init(id: "\($0.id)", name: $0.name, fullName: $0.fullName, description: $0.description, url: $0.htmlURL, fork: $0.fork)
        } ?? []
        
        return .init(items: items)
    }
}
