//
//  TutorialLayer.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 07/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//

class TutorialLayer: CALayer {
    private var roundedRects = [RoundedRect]()

    // MARK: - Internal

    func add(rect: RoundedRect) {
        roundedRects.append(rect)
        setNeedsDisplay()
    }

    // MARK: - Overriden

    override func draw(in context: CGContext) {
        context.setFillColor(UIColor.gray.cgColor)
        context.fill(bounds)
        roundedRects.forEach { roundedRect in
            let rect = CGRect(origin: roundedRect.origin, size: roundedRect.size)
            context.addPath(UIBezierPath(roundedRect: rect, cornerRadius: roundedRect.radius).cgPath)
        }
        context.setFillColor(UIColor.clear.cgColor)
        context.setBlendMode(.sourceIn)
        context.drawPath(using: .fill)
    }
}
