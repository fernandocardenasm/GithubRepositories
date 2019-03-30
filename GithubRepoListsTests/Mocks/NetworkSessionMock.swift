//
//  NetworkSessionMock.swift
//  GithubRepoListsTests
//
//  Created by Fernando on 30.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
@testable import GithubRepoLists

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
