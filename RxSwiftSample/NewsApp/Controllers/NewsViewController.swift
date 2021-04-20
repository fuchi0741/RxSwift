//
//  NewsViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import UIKit
import RxSwift

final class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cell")
        }
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        return cell
    }
}
