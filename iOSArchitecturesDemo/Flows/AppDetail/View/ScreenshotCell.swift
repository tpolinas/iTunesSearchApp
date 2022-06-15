//
//  ScreenshotCell.swift
//  iOSArchitecturesDemo
//
//  Created by Polina Tikhomirova on 15.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ScreenshotCell: UICollectionViewCell {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    private func configureUI() {
        self.contentView.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
        imageView.contentMode = .scaleAspectFill
    }
    
}

