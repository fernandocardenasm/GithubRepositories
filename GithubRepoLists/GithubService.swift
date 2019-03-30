//
//  GithubService.swift
//  GithubRepoLists
//
//  Created by Fernando Cardenas on 27.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import RxSwift

/// A service that knows how to perform requests for GitHub data.
class GithubService {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    /// - Returns: a list of languages from GitHub.
    func getLanguageList() -> Observable<[String]> {
        // For simplicity we will use a stubbed list of languages.
        return Observable.just([
            "Swift",
            "Objective-C",
            "Java",
            "C",
            "C++",
            "Python",
            "C#"
            ])
    }

    //    func fetchPlaceData() -> Observable<[Place]> {
    //        Observable<[Place]>.create { (observer) -> Disposable in
    //            let disposable = Disposables.create()
    //
    //            if let url = URL(string: "https://api.myjson.com/bins/16w6h0") {
    //                URLSession.shared.dataTask(with: url) { data, response, error in
    //                    if let data = data {
    //                        do {
    //                            let places = try JSONDecoder().decode([Place].self, from: data)
    //                        } catch let error {
    //                            print(error)
    //                        }
    //                    }
    //                }.resume()
    //            }
    //            return disposable
    //        }
    //    }
}
