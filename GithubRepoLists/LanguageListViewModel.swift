//
//  LanguageListViewModel.swift
//  GithubRepoLists
//
//  Created by Fernando on 30.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import RxSwift

class LanguageListViewModel {
    
    // MARK: - Inputs
    let selectLanguage: AnyObserver<String>
    
    // MARK: - Outputs
    let languages: Observable<[String]>
    
    init(githubService: GithubService = GithubService()) {
        self.languages = githubService.getLanguageList()
        self.selectLanguage = PublishSubject<String>().asObserver()
    }
}
