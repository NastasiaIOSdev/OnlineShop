//
//  OnboardingViewController.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    enum Event {
        case onboardingComplete
    }
    var didSendEventHandler: ((OnboardingViewController.Event) -> Void)?
    private var launchEventType: Event = .onboardingComplete
    
// MARK: - Property
    private let image = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        self.setupUi()
    }
}

private extension OnboardingViewController {
    private func setupUi() {
        self.image.image = UIImage(named: "Onboarding 1")
        self.image.contentMode = .scaleAspectFit
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
