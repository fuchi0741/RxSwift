//
//  PhotoViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/22.
//

import UIKit
import RxSwift

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func didTapTransitionButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PhotoCollectionViewController") as! PhotoCollectionViewController
        vc.modalPresentationStyle = .fullScreen
        
        vc.selectedPhoto.subscribe(onNext: { [weak self] photo in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
        
        present(vc, animated: true)
    }
    
    private func updateUI(with iamge: UIImage) {
        self.photoImageView.image = iamge
    }
}
