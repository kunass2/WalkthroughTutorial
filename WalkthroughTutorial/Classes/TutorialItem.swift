//
//  TutorialItem.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 03/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

public class TutorialItem {
    var view: UIView?
    var tag = 0

    // MARK: - Initialization

    public init(view: UIView?) {
        self.view = view
    }

    public init(tag: Int) {
        self.tag = tag
    }
}
