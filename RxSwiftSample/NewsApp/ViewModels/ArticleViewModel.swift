//
//  ArticleViewModel.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    
    init(_ articles: [Article]) {
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
    
}

extension ArticleListViewModel {
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
}

/////////////////////////////////////////

struct ArticleViewModel {
    let article: Article
    
    //TODO: ここは削除してもOK
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable.just(article.description ?? "")
    }
}
