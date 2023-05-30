//
//  UserDetailInteractorTests.swift
//  GithubForSwiftUITests
//
//  Created by Isami Odagiri on 2023/05/31.
//

import XCTest
@testable import GithubForSwiftUI

@MainActor
final class UserDetailInteractorTests: XCTestCase {

    var interactor: UserDetailInteractor<UserDetailRepositoryMock>!
    let repository: UserDetailRepositoryMock = .init()
    
    override func setUp() async throws {
        interactor = .init(repository: repository, state: .init(userName: ""))
    }

    func test_onAppear() async throws {
        
        let headerResult: UserDetailHeaderState = .init()
        let repositoryListResult: UserDetailRepositoryListState = .init()

        repository.fetchUserHandler = { _ in
            headerResult
        }
        
        repository.fetchRepositoryHandler = { _ in
            repositoryListResult
        }
        
        await interactor.onAppear()

        XCTAssertEqual(repository.fetchUserCallCount, 1)
        XCTAssertEqual(repository.fetchRepositoryCallCount, 1)
        XCTAssertEqual(interactor.state.header.id, headerResult.id)
        XCTAssertEqual(interactor.state.repositoryList.items.count, repositoryListResult.items.count)
        
    }
}
