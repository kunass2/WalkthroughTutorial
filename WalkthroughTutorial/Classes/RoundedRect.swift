//
//  RoundedRect.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 07/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//

struct RoundedRect {
    var origin: CGPoint
    var size: CGSize
    var radius: CGFloat

    // MARK: - Initialization

    init(rect: CGRect, radius: CGFloat) {
        origin = rect.origin
        size = rect.size
        self.radius = radius
    }
}
