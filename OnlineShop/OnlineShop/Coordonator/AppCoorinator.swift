//
//  AppCoorinator.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func start()
}

final class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }
    var dependencies: IDependencies
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
        self.dependencies = dependencies
    }
    func start() {
        self.shoeOnboardingFlow()
    }
    func shoeOnboardingFlow() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController, dependencies: dependencies)
        onboardingCoordinator.finishDelegate = self
        onboardingCoordinator.start()
        childCoordinators.append(onboardingCoordinator)
    }
    func showMainFlow() {
    }
}
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        case .onboarding:
            showMainFlow()
        case .app, .page: break
        }
    }
}
