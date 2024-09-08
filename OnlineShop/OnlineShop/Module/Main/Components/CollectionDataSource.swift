//
//  TableDataSource.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 07.05.2024.
//

import UIKit

final class CollectionDataSource {
    private let collectionView: UICollectionView
    private lazy var dataSource: DataSource = makeDataSource()
    
    var eventHandler: ((ProductCell.Event) -> Void)?
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        self.collectionView.dataSource = dataSource
    }
    func apply(_ content: [ProductDTO]) {
        var snapshot = DataSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(content, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CollectionDataSource {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, ProductDTO>
    typealias DataSnapshot = NSDiffableDataSourceSnapshot<Int, ProductDTO>
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell
            cell?.configure(with: product)
            cell?.handle { event in
                self.eventHandler?(event)
            }
            return cell
        }
        dataSource.supplementaryViewProvider = nil
        return dataSource
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.0 - 24
        let height: CGFloat = 227.0
        return CGSize(width: width, height: height)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
