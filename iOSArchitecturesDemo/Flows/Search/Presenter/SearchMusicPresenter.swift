//
//  SearchMusicPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Polina Tikhomirova on 15.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//


import UIKit

protocol SearchMusicViewInput: AnyObject {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
}

protocol SearchMusicViewOutput: AnyObject {
    func viewDidSearch(with query: String)
}

class SearchMusicPresenter {
    
    weak var viewInput: (UIViewController & SearchMusicViewInput)?
    
    // MARK: - Private Properties
    
    private let searchService = ITunesSearchService()
    
    // MARK: - Private Functions
    
    private func requestApps(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            result.withValue { songs in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            } .withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
}

// MARK: - Extensions

extension SearchMusicPresenter: SearchMusicViewOutput {
    func viewDidSearch(with query: String) {
        self.requestApps(with: query)
    }
}

