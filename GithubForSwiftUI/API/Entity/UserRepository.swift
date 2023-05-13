//
//  UserRepository.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

struct UserRepository: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let htmlURL: URL
    let description: String?
    let fork: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case description, fork
    }
    
    init(id: Int,
         nodeID: String,
         name: String,
         fullName: String,
         htmlURL: URL,
         description: String?,
         fork: Bool) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.htmlURL = htmlURL
        self.description = description
        self.fork = fork
    }
}
