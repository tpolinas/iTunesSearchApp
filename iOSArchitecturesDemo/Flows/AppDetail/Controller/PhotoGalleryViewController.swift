//
//  PhotoGalleryViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Polina Tikhomirova on 15.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()

    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var collectionView: UICollectionView!
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)
        layout.scrollDirection = .horizontal
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height / 4, width: self.view.frame.width, height: self.view.frame.width), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentMode = .scaleAspectFit
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        collectionView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        downloadImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
        
        guard let cell = dequeuedCell as? ScreenshotCell else {
            return dequeuedCell
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
    func downloadImages() {
        let urls = self.app.screenshotUrls
        urls.forEach { url in
            self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
                if let image = image {
                    self?.images.append(image)
                }
            }
        }
    }
    
}
