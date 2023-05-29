//
//  SearchUserRepository.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/14.
//

import Foundation
/// @mockable
protocol SearchUserRepository {
    func fetchUserList(query: String) async throws -> [SearchUserDetailState]
}

struct SearchUserRepositoryImpl: SearchUserRepository {
    func fetchUserList(query: String) async throws -> [SearchUserDetailState] {
        let session = Session()
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil)
        let result = try await session.send(request)
        return result?.items.map {
            .init(id: "\($0.id)", name: $0.login, profileImage: $0.avatarURL)
        } ?? []
    }
}
