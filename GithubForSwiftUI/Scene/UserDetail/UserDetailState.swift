//
//  UserDetailState.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

protocol UserDetailStateProtocol: ObservableObject {
    var userName: String { get }
    var header: UserDetailHeaderState { get }
    var repositoryList: UserDetailRepositoryListState { get }
}

final class UserDetailState: UserDetailStateProtocol {
    @Published var headerPublished: UserDetailHeaderState
    @Published var repositoryListPublished: UserDetailRepositoryListState
    
    let userName: String
    var header: UserDetailHeaderState {
        headerPublished
    }
    var repositoryList: UserDetailRepositoryListState {
        repositoryListPublished
    }

    init(userName: String = "", header: UserDetailHeaderState = .init(), repositoryList: UserDetailRepositoryListState = .init()) {
        self.userName = userName
        headerPublished = header
        repositoryListPublished = repositoryList
    }
}

protocol UserDetailHeaderStateProtocol: ObservableObject {
    var id: String { get }
    var name: String { get }
    var profileImage: URL? { get }
    var followers: Int { get }
    var following: Int { get }
}

final class UserDetailHeaderState: UserDetailHeaderStateProtocol {
    @Published var idPublished: String
    @Published var namePublished: String
    @Published var profileImagePublished: URL?
    @Published var followersPublished: Int
    @Published var followingPublished: Int

    var id: String {
        idPublished
    }
    var name: String {
        namePublished
    }
    var profileImage: URL? {
        profileImagePublished
    }
    var followers: Int {
        followersPublished
    }
    var following: Int {
        followingPublished
    }
    
    init(id: String = "", name: String = "", profileImage: URL? = nil, followers: Int = 0, following: Int = 0) {
        idPublished = id
        namePublished = name
        profileImagePublished = profileImage
        followersPublished = followers
        followingPublished = following
    }
}

protocol UserDetailRepositoryListStateProtocol: ObservableObject {
    var items: [UserDetailRepositoryDetailState] { get }
}

final class UserDetailRepositoryListState: UserDetailRepositoryListStateProtocol {
    @Published var itemsPublished: [UserDetailRepositoryDetailState]
    
    var items: [UserDetailRepositoryDetailState] {
        itemsPublished
    }
    
    init(items: [UserDetailRepositoryDetailState] = []) {
        itemsPublished = items
    }
}

protocol UserDetailRepositoryDetailStateProtocol: ObservableObject {
    var id: String { get }
    var name: String { get }
    var fullName: String { get }
    var description: String? { get }
    var url: URL? { get }
    var fork: Bool { get }
}

final class UserDetailRepositoryDetailState: UserDetailRepositoryDetailStateProtocol {
    @Published var idPublished: String
    @Published var namePublished: String
    @Published var fullNamePublished: String
    @Published var descriptionPublished: String?
    @Published var urlPublished: URL?
    @Published var forkPublished: Bool

    var id: String {
        idPublished
    }
    var name: String {
        namePublished
    }
    var fullName: String {
        fullNamePublished
    }
    var description: String? {
        descriptionPublished
    }
    var url: URL? {
        urlPublished
    }
    var fork: Bool {
        forkPublished
    }
    
    init(id: String = "", name: String = "", fullName: String = "", description: String? = nil, url: URL? = nil, fork: Bool = false) {
        idPublished = id
        namePublished = name
        fullNamePublished = fullName
        descriptionPublished = description
        urlPublished = url
        forkPublished = fork
    }
}
