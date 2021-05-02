//
//  CountUpViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/05/02.
//

import UIKit
import RxSwift

class CountUpViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var countupButton: UIButton!
    @IBOutlet var countDownButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: CounterRxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = CounterRxViewModel()
        let input = CounterViewModelInput(
            countUpButton: countupButton.rx.tap.asObservable(),
            countDownButton: countDownButton.rx.tap.asObservable(),
            countResetButton: resetButton.rx.tap.asObservable()
        )
        
        viewModel.setup(input: input)
        
        viewModel.outputs?.counterText
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
