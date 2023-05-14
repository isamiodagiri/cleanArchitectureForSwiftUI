//
//  GithubForSwiftUIApp.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI

@main
struct GithubForSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            SearchUserScreenView(interactor: .init(repository: SearchUserRepositoryImpl()))
        }
    }
}
