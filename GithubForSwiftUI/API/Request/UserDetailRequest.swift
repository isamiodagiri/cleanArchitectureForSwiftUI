//
//  UserDetailRequest.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

struct UserDetailRequest: Request {
    typealias Response = UserDetail
    
    let method: HttpMethod = .get
    
    let path: String
    
    init(userName: String) {
        path = "users/\(userName)"
    }
}
