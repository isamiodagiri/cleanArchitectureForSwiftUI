//
//  SearchUserInteractorTests.swift
//  GithubForSwiftUITests
//
//  Created by Isami Odagiri on 2023/05/28.
//

import XCTest
@testable import GithubForSwiftUI

final class SearchUserInteractorTests: XCTestCase {
    
    var interactor: SearchUserInteractor<SearchUserRepositoryImpl>!
    
    @MainActor
    override func setUp() async throws {
        interactor = .init(repository: SearchUserRepositoryImpl())
    }

    @MainActor
    func test_OnAppear() async throws {
        await interactor.onAppear()
        XCTAssertTrue(interactor.state.items.count > 0)
    }
}
