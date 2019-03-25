//
//  ViewController.swift
//  GithubRepoLists
//
//  Created by Fernando on 21.03.19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
                                                    constant: -10)
            ].forEach { $0.isActive = true}
    }
    
    private func registerCellForLanguagesTableView() {
        languagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.languagesReuseIdentifier)
    }
    
    private func setupBindings() {
        languagesListViewModel.languages
        .observeOn(MainScheduler.instance)
        .bind(to: languagesTableView.rx.items(cellIdentifier: Constants.languagesReuseIdentifier)) { row, model, cell in
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
        self.name = repository.fullName
        self.description = repository.description
        self.starsCountText = "⭐️ \(repository.starsCount)"
        self.url = URL(string: repository.url)!
    }
}

/// A service that knows how to perform requests for GitHub data.
class GithubService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
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
