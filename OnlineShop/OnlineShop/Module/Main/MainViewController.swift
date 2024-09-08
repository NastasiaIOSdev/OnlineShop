//
//  MainViewController.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    enum Event {
        case onboardingComplete
    }
    var didSendEventHandler: ((OnboardingViewController.Event) -> Void)?
    private var launchEventType: Event = .onboardingComplete
    
// MARK: - Property
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var dataSource = CollectionDataSource(collectionView)
    private var cancelable = Set<AnyCancellable>()
    private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        view.backgroundColor = .cyan
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        viewModel
            .productsPublisher
            .sink(receiveValue: dataSource.apply(_:))
            .store(in: &cancelable)
        viewModel.viewDidLoad()
        dataSource.eventHandler = { event in
            switch event {
            case .tap(let id):
                print(id.description)
            }
        }
    }
}
