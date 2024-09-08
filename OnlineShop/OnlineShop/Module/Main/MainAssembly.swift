//
//  MainAssembly.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import UIKit

final class MainAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getMainView()
    }
}
