//
//  TodoListViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/05/08.
//

import UIKit
import RxSwift
import RxCocoa

final class TodoListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    @IBOutlet weak private var priorySegementedControl: UISegmentedControl!
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nib = UINib(nibName: "TodoListTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "TodoListTableViewCell")
        }
    }
    
    @IBAction private func didTapPrityValueChanged(_ sender: UISegmentedControl) {
        let AllSegementedItem = 1
        let priority = Priority(rawValue: sender.selectedSegmentIndex - AllSegementedItem)
        return filterTasks(by: priority)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddToDoViewController else { return }

        
        //監視する対象を見る
        vc.taskSubjectObservable.subscribe(onNext: { [weak self] task in
            guard let self = self else { return }
            
            let AllSegementedItem = 1
            let priority = Priority(rawValue: self.priorySegementedControl.selectedSegmentIndex - AllSegementedItem)
            
            var existingTasks = self.tasks.value
            existingTasks.append(task)
            
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: priority)
        }).disposed(by: disposeBag)
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                guard let self = self else { return }
                self.filteredTasks = tasks
                self.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
        let item = filteredTasks[indexPath.row]
        cell.configure(title: item.title, priority: item.priority)
        return cell
    }
}
