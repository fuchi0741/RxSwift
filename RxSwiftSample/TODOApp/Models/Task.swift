//
//  Task.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/05/08.
//

import Foundation

enum Priority: Int {
    case high, medium, low
}

struct Task {
    let title: String
    let priority: Priority
}
