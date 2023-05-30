//
//  SearchUserInteractorTests.swift
//  GithubForSwiftUITests
//
//  Created by Isami Odagiri on 2023/05/28.
//

import XCTest
@testable import GithubForSwiftUI

@MainActor
final class SearchUserInteractorTests: XCTestCase {
    
    var interactor: SearchUserInteractor<SearchUserRepositoryMock>!
    let repository: SearchUserRepositoryMock = .init()
    
    override func setUp() async throws {
        interactor = .init(repository: repository)
    }

    
    func test_onAppear() async throws {
        repository.fetchUserListHandler = { _ in
            [.init()]
        }
        
        await interactor.onAppear()
        
        XCTAssertEqual(repository.fetchUserListCallCount, 1)
        XCTAssertEqual(interactor.state.items.count, 1)
    }
    
    func test_onSubmitSearch() async throws {
        repository.fetchUserListHandler = { _ in
            [.init()]
        }
        
        await interactor.onSubmitSearch()
        
        XCTAssertEqual(repository.fetchUserListCallCount, 1)
        XCTAssertEqual(interactor.state.items.count, 1)
    }
    
    func test_onSearchableText() async throws {
        repository.fetchUserListHandler = { _ in
            [.init()]
        }
        
        interactor.onSearchableText("test")
        
        XCTAssertEqual(interactor.state.keyWord, "test")
    }
}
