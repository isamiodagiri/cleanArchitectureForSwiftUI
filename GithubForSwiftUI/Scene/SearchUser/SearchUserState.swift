//
//  SearchUserState.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation
/// @mockable
protocol SearchUserStateProtocol: ObservableObject {
    var keyWord: String { get }
    var items: [SearchUserDetailState] { get }
}

final class SearchUserState: SearchUserStateProtocol {
    @Published var keyWordPublished: String
    @Published var itemsPublished: [SearchUserDetailState]

    var keyWord: String {
        keyWordPublished
    }

    var items: [SearchUserDetailState] {
        itemsPublished
    }
    
    init(keyWord: String = "", items: [SearchUserDetailState] = []) {
        keyWordPublished = keyWord
        itemsPublished = items
    }
}
/// @mockable
protocol SearchUserDetailStateProtocol: ObservableObject {
    var id: String { get }
    var name: String { get }
    var profileImage: URL? { get }
}

final class SearchUserDetailState: SearchUserDetailStateProtocol {
    @Published var idPublished: String
    @Published var namePublished: String
    @Published var profileImagePublished: URL?

    var id: String {
        idPublished
    }
    
    var name: String {
        namePublished
    }

    var profileImage: URL? {
        profileImagePublished
    }
    
    init(id: String = "", name: String = "", profileImage: URL? = nil) {
        idPublished = id
        namePublished = name
        profileImagePublished = profileImage
    }
}
