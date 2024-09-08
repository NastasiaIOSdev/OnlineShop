//
//  OnboardingAssembly.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//
import UIKit

final class OnboardingAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getOnboardingView()
    }
}
