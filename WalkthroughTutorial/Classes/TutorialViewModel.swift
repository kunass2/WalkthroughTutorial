//
//  TutorialViewModel.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 02/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//
import RxCocoa
import UIKit

protocol TutorialViewModelable {
    var configuration: TutorialConfiguration { get }
    var nextPage: TutorialPage? { get }
    var previousPage: TutorialPage? { get }
    var isLastPage: Bool { get }
}

class TutorialViewModel: TutorialViewModelable {
    private var pages: [TutorialPage]
    let configuration: TutorialConfiguration
    private var currentPage: TutorialPage?
    private var pastPages = [TutorialPage]()
    var nextPage: TutorialPage? {
        guard !pages.isEmpty else {
            return nil
        }
        if let currentPage = currentPage {
            pastPages.append(currentPage)
        }
        currentPage = pages.removeFirst()
        return currentPage
    }

    var previousPage: TutorialPage? {
        guard !pastPages.isEmpty else {
            return nil
        }
        if let currentPage = currentPage {
            pages.insert(currentPage, at: 0)
        }
        currentPage = pastPages.removeLast()
        return currentPage
    }

    var isLastPage: Bool {
        pages.isEmpty
    }

    // MARK: - Initialization

    init(pages: [TutorialPage], configuration: TutorialConfiguration) {
        self.pages = pages
        self.configuration = configuration
    }
}
