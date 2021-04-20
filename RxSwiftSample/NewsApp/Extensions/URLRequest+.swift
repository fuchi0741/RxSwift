//
//  URLRequest+.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { (url) -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { (data) -> T in
                //dataはレスポンスされたJSONのデータ
                //TはArticleResponse型
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
