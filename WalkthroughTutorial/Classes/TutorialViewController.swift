//
//  TutorialViewController.swift
//  Bartłomiej Semańczyk
//
//  Created by Bartłomiej Semańczyk on 02/06/2022.
//  Copyright © 2022 Bartłomiej Semańczyk. All rights reserved.
//
import RxSwift

public class TutorialViewController: UIViewController {
    private let mainView: TutorialView
    private let viewModel: TutorialViewModelable
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    public init(pages: [TutorialPage], configuration: TutorialConfiguration) {
        mainView = TutorialView(configuration: configuration)
        viewModel = TutorialViewModel(pages: pages, configuration: configuration)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }

    // MARK: - Private

    private func setupView() {
        view = mainView
        mainView.setup()
    }

    private func setupActions() {
        mainView.skipButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
        mainView.nextButton.rx.tap.bind { [weak self] in
            self?.update()
        }.disposed(by: disposeBag)
        mainView.readyButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func update() {
        mainView.setup(with: viewModel.nextPage, isLastPage: viewModel.isLastPage)
    }
}
