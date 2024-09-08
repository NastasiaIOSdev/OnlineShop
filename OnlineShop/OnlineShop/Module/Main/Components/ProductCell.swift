//
//  ProductCell.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 07.05.2024.
//

import UIKit
import SnapKit
import SDWebImage

final class ProductCell: UICollectionViewCell {
// MARK: - Property
    static let identifier = String(describing: ProductCell.self)
    private let content = UIView()
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let addButton = UIButton(type: .system)
    
    var productId = Int()
    var eventHandler: ((Event) -> Void)?

// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImageView.image = nil
        self.titleLabel.text = nil
        self.priceLabel.text = nil
    }
// MARK: - Configure
    func configure(with product: ProductDTO) {
        self.titleLabel.text = product.title
        self.priceLabel.text = "$\(product.price)"
        self.productId = product.id
        if let imageURL = product.images.first.map(URL.init(string:)) {
            self.productImageView.sd_setImage(
                with: imageURL,
                placeholderImage: UIImage(named: "noPhoto"),
                completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    print("Failed to load image with error: \(error.localizedDescription)")
                }
            })
        }
        else {
            self.productImageView.image = UIImage(named: "noPhoto")
        }
    }
    
    enum Event {
        case tap(_ id: Int)
    }
    
    func handle(_ eventHandler: @escaping (Event) -> Void) {
        self.eventHandler = eventHandler
    }
}
// MARK: - SetupUi
private extension ProductCell {
    private func setupUI() {
        contentView.addSubview(self.content)
        self.content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.setupProductImageView()
        self.setupTitleLabel()
        self.setupPriceLabel()
        self.setupAddButton()
    }
    private func setupProductImageView() {
        self.content.addSubview(self.productImageView)
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.contentMode = .scaleToFill
        self.productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
    }
    private func setupTitleLabel() {
        self.content.addSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
        self.titleLabel.font = AppFonts.regular12.font
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.productImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    private func setupPriceLabel() {
        self.content.addSubview(self.priceLabel)
        self.priceLabel.font = AppFonts.bold14.font
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
        }
    }
    private func setupAddButton() {
        self.content.addSubview(self.addButton)
        self.addButton.layer.cornerRadius = 4
        self.addButton.backgroundColor = AppColors.green
        self.addButton.setTitleColor(.white, for: .normal)
        self.addButton.titleLabel?.font = AppFonts.regular12.font
        self.addButton.setTitle("Add to Cart", for: .normal)
        self.addButton.addTarget(self, action: #selector(self.addButtonTapped), for: .touchUpInside)
        self.addButton.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
}
// MARK: - Action
private extension ProductCell {
    @objc func addButtonTapped() {
        eventHandler?(.tap(productId))
    }
}
