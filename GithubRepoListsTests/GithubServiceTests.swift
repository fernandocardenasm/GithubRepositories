//
//  GithubServiceTests.swift
//  GithubRepoListsTests
//
//  Created by Fernando on 25.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

@testable import GithubRepoLists
import RxSwift
import RxTest
import XCTest

class GithubServiceTests: XCTestCase {
    func test_getLanguageList() {
        let disposeBag = DisposeBag()
        let networkSession = NetworkSessionMock()
        let service = GithubService(session: networkSession)
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver([String].self)
        
        service.getLanguageList()
            .observeOn(scheduler)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let expectedEvents = [
            next(1, [
                "Swift",
                "Objective-C",
                "Java",
                "C",
                "C++",
                "Python",
                "C#"
            ]),
            completed(2)
        ]
        XCTAssertEqual(observer.events, expectedEvents)
    }
}
