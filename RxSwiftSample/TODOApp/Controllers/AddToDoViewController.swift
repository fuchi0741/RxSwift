//
//  AddToDoViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/05/08.
//

import UIKit
import RxSwift

final class AddToDoViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegementdControl: UISegmentedControl!
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        
        guard let priority = Priority(rawValue: self.prioritySegementdControl.selectedSegmentIndex),
              let title = self.todoTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        dismiss(animated: true, completion: nil)
    }
}
