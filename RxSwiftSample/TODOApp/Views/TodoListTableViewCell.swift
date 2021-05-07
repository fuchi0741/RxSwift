//
//  TodoListTableViewCell.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/05/08.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var taskTitleLabel: UILabel!
    @IBOutlet weak private var priorityLabel: UILabel!
    
    func configure(title: String, priority: Priority) {
        taskTitleLabel.text = title
        priorityLabel.text = priority.title
    }
}

extension Priority {
    var title: String {
        switch self {
        case .high: return "緊急"
        case .medium: return "普通"
        case .low: return "いつか"
        }
    }
}
