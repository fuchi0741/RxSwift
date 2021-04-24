//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func basicRxSwift(_ sender: UIButton) {
        performSegue(withIdentifier: "toPhoto", sender: nil)
    }
    
    @IBAction func MVVMWithRxSwift(_ sender: UIButton) {
        performSegue(withIdentifier: "toMVVM", sender: nil)
    }
}

