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
        // Do any additional setup after loading the view.
    }

    @IBAction func MVVMWithRxSwift(_ sender: UIButton) {
        print("えもじ")
        performSegue(withIdentifier: "toMVVM", sender: nil)
    }
}

