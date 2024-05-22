//
//  TutorialView.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 02/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//
import SnapKit
import UIKit

class TutorialView: UIView {
    private let configuration: TutorialConfiguration
    private lazy var blurView: UIVisualEffectView = {
        UIVisualEffectView(effect: configuration.blurEffect)
    }()

    private let contentWrapperView = UIView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontMetrics.default.scaledFont(for: configuration.titleFont)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = configuration.titleColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontMetrics.default.scaledFont(for: configuration.descriptionFont)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = configuration.descriptionColor
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()

    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(configuration.skipButtonTitle, for: .normal)
        button.setTitleColor(configuration.navigationButtonsColor, for: .normal)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: configuration.navigationButtonsFont)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        return button
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(configuration.nextButtonTitle, for: .normal)
        button.setTitleColor(configuration.navigationButtonsColor, for: .normal)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: configuration.navigationButtonsFont)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        return button
    }()
    lazy var readyButton: UIButton = {
        let button = UIButton()
        button.setTitle(configuration.readyButtonTitle, for: .normal)
        button.setTitleColor(configuration.navigationButtonsColor, for: .normal)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: configuration.navigationButtonsFont)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        return button
    }()
    
    // MARK: - Initialization
    
    init(configuration: TutorialConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Internal

    func setup() {
        addSubview(blurView)
        blurView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        addSubview(contentWrapperView)
        contentWrapperView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(safeAreaLayoutGuide)
        }
        contentWrapperView.addSubview(skipButton)
        skipButton.snp.makeConstraints { maker in
            maker.leading.equalTo(20)
            maker.bottom.equalTo(-20)
            maker.height.equalTo(30)
        }
        contentWrapperView.addSubview(nextButton)
        nextButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(-20)
            maker.bottom.equalTo(-20)
            maker.height.equalTo(30)
        }
        contentWrapperView.addSubview(readyButton)
        readyButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(-20)
            maker.bottom.equalTo(-20)
            maker.height.equalTo(30)
        }
        contentWrapperView.addSubview(descriptionLabel)
//        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        descriptionLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.bottom.equalTo(skipButton.snp.top).offset(-20)
        }
        contentWrapperView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.top.equalToSuperview()
            maker.bottom.equalTo(descriptionLabel.snp.top).offset(-20)
        }
    }

    func setup(with page: TutorialPage?, isLastPage: Bool) {
        blurView.frame = bounds
        if let page = page {
            titleLabel.text = page.title
            descriptionLabel.text = page.description
            contentWrapperView.layoutIfNeeded()
            let views = page.items.compactMap { $0.view ?? window?.viewWithTag($0.tag) }
            createMask(for: views)
            updateContentWrapperViewPosition(for: views)
        }
        nextButton.isHidden = isLastPage
        readyButton.isHidden = !isLastPage
        skipButton.isHidden = isLastPage
    }

    // MARK: - Private

    private func createMask(for views: [UIView]) {
        let layer = TutorialLayer()
        layer.frame = blurView.bounds
        blurView.layer.mask = layer
        views.forEach { view in
            layer.add(rect: rect(for: view))
        }
    }

    private func rect(for view: UIView) -> RoundedRect {
        let rect = view.convert(view.bounds, to: nil)
        let offset: Double = 4
        let x = rect.origin.x - offset
        let y = rect.origin.y - offset
        let width = rect.size.width + 2 * offset
        let height = rect.size.height + 2 * offset
        return RoundedRect(rect: CGRect(x: x, y: y, width: width, height: height), radius: view.layer.cornerRadius)
    }

    private func updateContentWrapperViewPosition(for views: [UIView]) {
        let height = window?.bounds.size.height ?? 0
        let bottomInset = window?.safeAreaInsets.bottom ?? 0
        var offsets = [0, height]
        views.forEach { view in
            let rect = rect(for: view)
            let topY = rect.origin.y
            if topY < height, height > 0 {
                offsets.append(topY)
                offsets.append(rect.origin.y + rect.size.height)
            }
        }
        offsets = offsets.sorted { $0 < $1 }
        var calculatedOffset = CGFloat(0)
        var highestDifference = CGFloat(0)
        var highestOffset = CGFloat(0)
        _ = offsets.reduce(calculatedOffset) { previousOffset, currentOffset in
            let difference = currentOffset - previousOffset
            if difference >= contentWrapperView.bounds.size.height {
                calculatedOffset = currentOffset
            }
            if difference >= highestDifference {
                highestDifference = difference
                highestOffset = currentOffset
            }
            return currentOffset
        }
        
        if calculatedOffset == 0 {
            calculatedOffset = highestOffset + bottomInset
        } else if calculatedOffset < height {
            calculatedOffset = calculatedOffset + bottomInset
        }
        contentWrapperView.snp.remakeConstraints { maker in
            maker.bottom.equalTo(safeAreaLayoutGuide).offset(calculatedOffset - height)
            maker.leading.trailing.equalToSuperview()
            if contentWrapperView.bounds.size.height > highestDifference {
                maker.height.equalTo(highestDifference - 20)
            }
        }
    }
}
