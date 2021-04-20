//
//  NewsViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import UIKit
import RxSwift

final class NewsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    private var articleList: ArticleListViewModel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateNews()
    }
    
    private func populateNews() {
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!)
        URLRequest.load(resource: resource).subscribe(onNext: { articleResponse in
            let articles = articleResponse.articles
            self.articleList = ArticleListViewModel(articles)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articleList == nil ? 0: self.articleList.articlesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArticleTableViewCell else { return UITableViewCell()}
        
        let articleVM = self.articleList.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
        .drive(cell.titleLabel.rx.text)
        .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        return cell
    }
}
