//
//  SearchUserInteractorTests.swift
//  GithubForSwiftUITests
//
//  Created by Isami Odagiri on 2023/05/28.
//

import XCTest
@testable import GithubForSwiftUI

final class SearchUserInteractorTests: XCTestCase {
    
    var interactor: SearchUserInteractor<SearchUserRepositoryMock>!
    let repository: SearchUserRepositoryMock = .init()
    
    @MainActor
    override func setUp() async throws {
        interactor = .init(repository: repository)
    }

    @MainActor
    func test_OnAppear() async throws {
        repository.fetchUserListHandler = { _ in
            [.init()]
        }
        
        await interactor.onAppear()
        
        XCTAssertEqual(repository.fetchUserListCallCount, 1)
        XCTAssertEqual(interactor.state.items.count, 1)
    }
}
