//
//  Article.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
