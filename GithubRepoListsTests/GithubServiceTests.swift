//
//  GithubServiceTests.swift
//  GithubRepoListsTests
//
//  Created by Fernando on 25.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import GithubRepoLists

class GithubServiceTests: XCTestCase {
    func test_getLanguageList() {
        let disposeBag = DisposeBag()
        let urlSession = URLSessionMock()
        let service = GithubService(session: urlSession)
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(String.self)
        
        service.getLanguageList().bind(to: observer).di
    }
}

class URLSessionMock: URLSession {
    
}
