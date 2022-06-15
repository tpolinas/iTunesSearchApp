//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Rubtsov on 21.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class SearchModuleBuilder {
    @available(iOS 13.0, *)
    static func build() -> (UITabBarController) {
        
        let presenter = SearchPresenter()
        let viewController = SearchViewController(presenter: presenter)
        presenter.viewInput = viewController
        viewController.tabBarItem = UITabBarItem(title: "Apps", image: UIImage(systemName: "square.stack.3d.up"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
        
        let searchMusicPresenter = SearchMusicPresenter()
        let musicViewController = SearchMusicViewController(presenter: searchMusicPresenter)
        searchMusicPresenter.viewInput = musicViewController
        musicViewController.tabBarItem = UITabBarItem(title: "Music", image: UIImage(systemName: "play.circle"), selectedImage: UIImage(systemName: "play.circle.fill"))
        
        let tabBarController = TabBarController(controllers: [viewController, musicViewController])
        return tabBarController
    }
}
