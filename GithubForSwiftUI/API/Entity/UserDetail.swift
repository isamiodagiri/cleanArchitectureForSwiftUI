//
//  UserDetail.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

struct UserDetail: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: URL
    let type: String
    let name: String?
    let followers: Int
    let following: Int

    private enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case type, name, followers, following
    }
    
    init(login: String,
         id: Int,
         nodeID: String,
         avatarURL: URL,
         gravatarID: String,
         type: String,
         name: String?,
         followers: Int,
         following: Int) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.type = type
        self.name = name
        self.followers = followers
        self.following = following
    }
}
