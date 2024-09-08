//
//  OnboardingCoordinator.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import UIKit

protocol OnboardingCoordinatorProtocol: Coordinator {
    func start()
    func startFirstLaunch()
}

final class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .onboarding }
    var dependencies: IDependencies
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    func start() {
        showOnboardingViewController(isShowOnboardingBefore: true)
    }
    func startFirstLaunch() {
        showOnboardingViewController()
    }
    func showOnboardingViewController(isShowOnboardingBefore: Bool = false) {
        let onboardingViewController = MainAssembly.configure(dependencies)
        if let onboardingViewController = onboardingViewController as? MainViewController {
            onboardingViewController.didSendEventHandler = { [weak self] event in
                switch event {
                case .onboardingComplete:
                    self?.finish()
                }
            }
        }
        navigationController.show(onboardingViewController, sender: self)
    }
}
