//
//  ViewController.swift
//  GithubRepoLists
//
//  Created by Fernando on 21.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    lazy var languagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let languagesListViewModel = LanguageListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        registerCellForLanguagesTableView()
        setupBindings()
    }
    
    private func setupViews() {
        view.addSubview(languagesTableView)
        [languagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: 20),
         languagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: 10),
         languagesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -10),
         languagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -10)].forEach { $0.isActive = true }
    }
    
    private func registerCellForLanguagesTableView() {
        languagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.languagesReuseIdentifier)
    }
    
    private func setupBindings() {
        languagesListViewModel.languages.asDriver(onErrorJustReturn: [])
            .drive(languagesTableView.rx.items(cellIdentifier: Constants.languagesReuseIdentifier)) { _, model, cell in
                cell.textLabel?.text = model.capitalized
            }.disposed(by: disposeBag)
    }
    
    private struct Constants {
        static let languagesReuseIdentifier = "languagesTableViewId"
    }
}

struct Repository {
    let fullName: String
    let description: String
    let starsCount: Int
    let url: String
}

extension Repository {
    init?(from json: [String: Any]) {
        guard
            let fullName = json["full_name"] as? String,
            let description = json["description"] as? String,
            let starsCount = json["stargazers_count"] as? Int,
            let url = json["html_url"] as? String
        else { return nil }
        
        self.init(fullName: fullName, description: description, starsCount: starsCount, url: url)
    }
}

struct Place: Decodable {
    let name: String
    let desc: String
    let url: String
}

class RepositoryViewModel {
    let name: String
    let description: String
    let starsCountText: String
    let url: URL
    
    init(repository: Repository) {
        name = repository.fullName
        description = repository.description
        starsCountText = "⭐️ \(repository.starsCount)"
        url = URL(string: repository.url)!
    }
}
