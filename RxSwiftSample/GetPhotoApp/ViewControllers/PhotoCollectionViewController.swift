//
//  PhotoCollectionViewController.swift
//  RxSwiftSample
//
//  Created by 渕一真 on 2021/04/22.
//

import UIKit
import Photos
import RxSwift

class PhotoCollectionViewController: UIViewController {
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
        
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }
    
    private func fetchPhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self.images.append(object)
                }
                self.images.reverse()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 300, height: 300),
                             contentMode: .aspectFit,
                             options: nil) { (image, _) in
            
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let self = self,
                  let info = info,
                  let image = image else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                self.selectedPhotoSubject.onNext(image)
                self.dismiss(animated: true)
            }
        }
    }
}
