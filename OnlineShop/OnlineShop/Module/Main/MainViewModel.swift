//
//  MainViewModel.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//
import Foundation
import Combine

protocol MainViewModel: AnyObject {
    var productsPublisher: Published<[ProductDTO]>.Publisher { get }
    
    func viewDidLoad()
}

final class MainViewModelImpl: MainViewModel {
    private let queue = DispatchQueue.main
    private let networking: NetworkService
    
    private var deliveryAdress: String = ""
    private var cartCounter: Int = 0
    private var notificationCounter: Int = 0
    private var searchQuery: String = ""
    private var category: [Category] = []
    private var filtr: Filter = .price
    private var isCategoryColapsed: Bool = false
    
    @Published private var products: [ProductDTO] = .init()
    
    var productsPublisher: Published<[ProductDTO]>.Publisher { $products }
    
    // MARK: - Init
    init(networking: NetworkService) {
        self.networking = networking
    }
    func viewDidLoad() {
        self.getProductData()
    }
    
    func getProductData() {
        networking.getProducts()
            .replaceError(with: [])
            .receive(on: queue)
            .assign(to: &$products)
    }
}

extension MainViewModelImpl {
    enum Filter {
        case name
        case price
        case priceRange
    }
}
