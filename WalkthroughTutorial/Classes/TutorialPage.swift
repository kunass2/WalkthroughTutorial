//
//  TutorialPage.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 03/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//

public class TutorialPage {
    let items: [TutorialItem]
    let title: String
    let description: String

    // MARK: - Initialization

    public init(items: [TutorialItem], title: String, description: String) {
        self.items = items
        self.title = title
        self.description = description
    }
}
