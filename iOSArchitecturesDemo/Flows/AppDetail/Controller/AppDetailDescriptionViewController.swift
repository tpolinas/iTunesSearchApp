//
//  AppDetailDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Polina Tikhomirova on 15.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailDescriptionViewController: UIViewController {
    private let app: ITunesApp
    private var appDetailDescriptionView: AppDetailDescriptionView {
        return self.view as! AppDetailDescriptionView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let newFormDate = dateFormatter.date(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let str = formatter.string(from: newFormDate ?? Date())
        return str
    }
    
    private func fillData() {
        guard
            let version = app.version,
            let defaultFormDate = app.currentVersionReleaseDate
        else { return }
        let date = dateFormatter(date: defaultFormDate)
        appDetailDescriptionView.descriptionTitle.text = "What's new"
        appDetailDescriptionView.versionTitle.text = "Version \(version)"
        appDetailDescriptionView.updateDateLabel.text = date
        appDetailDescriptionView.descriptionText.text = app.appDescription
    }
}
