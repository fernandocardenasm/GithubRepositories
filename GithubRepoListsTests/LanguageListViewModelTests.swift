//
//  LanguageListViewModelTests.swift
//  GithubRepoListsTests
//
//  Created by Fernando on 30.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

@testable import GithubRepoLists
import RxSwift
import XCTest

class LanguageListViewModelTests: XCTestCase {
    func test_init() {
        let networkSession = NetworkSessionMock()
        let githubService = GithubServiceMock(session: networkSession)
        let viewModel = LanguageListViewModel(githubService: githubService)

        // TO DO: Evaluate whether the init is done correctly
    }
}

class GithubServiceMock: GithubService {
    override func getLanguageList() -> Observable<[String]> {
        return Observable.just([])
    }
}
