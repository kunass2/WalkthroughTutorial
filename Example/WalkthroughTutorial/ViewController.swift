//
//  ViewController.swift
//  WalkthroughTutorial
//
//  Created by kunass2 on 06/08/2022.
//  Copyright (c) 2022 kunass2. All rights reserved.
//

import WalkthroughTutorial
import SnapKit
import UIKit

class ViewController: UIViewController {
    let yellowView = UIView()
    let greenView = UIView()
    let brownView = UIView()
    let purpleView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentTutorial()
    }
    
    private func addSubviews() {
        yellowView.backgroundColor = .yellow
        yellowView.layer.cornerRadius = 8
        greenView.backgroundColor = .green
        greenView.layer.cornerRadius = 20
        brownView.backgroundColor = .brown
        brownView.layer.cornerRadius = 10
        purpleView.backgroundColor = .purple
        purpleView.layer.cornerRadius = 30
        view.addSubview(yellowView)
        yellowView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(40)
            maker.top.equalTo(100)
            maker.height.equalTo(100)
        }
        view.addSubview(greenView)
        greenView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.size.equalTo(100)
            maker.top.equalTo(50)
        }
        view.addSubview(brownView)
        brownView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.size.equalTo(100)
        }
        view.addSubview(purpleView)
        purpleView.snp.makeConstraints { maker in
            maker.trailing.bottom.equalToSuperview().inset(40)
            maker.size.equalTo(100)
        }
    }
    
    private func presentTutorial() {
        let pages = [
            TutorialPage(
                items: [
                    TutorialItem(view: yellowView),
                    TutorialItem(view: greenView),
                ],
                title: "First Initial page",
                description: "- lorem ipsum first"
            ),
            TutorialPage(
                items: [
                    TutorialItem(view: brownView),
                ],
                title: "Second Initial page",
                description: "- lorem ipsum second"
            ),
            TutorialPage(
                items: [
                    TutorialItem(view: purpleView),
                ],
                title: "Third Initial page",
                description: "- lorem ipsum third"
            ),
        ]
        var blurEffect = UIBlurEffect(style: .dark)
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        }
        let configuration = TutorialConfiguration(blurEffect: blurEffect)
        let controller = TutorialViewController(pages: pages, configuration: configuration)
        controller.modalPresentationStyle = .overCurrentContext
        present(controller, animated: true)
    }
}

