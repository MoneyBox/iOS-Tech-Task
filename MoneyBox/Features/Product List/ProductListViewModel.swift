//
//  ProductListViewModel.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
import MoneyBoxUI
import Networking

final class ProductListViewModel: ObservableObject {
    
    enum Section: Hashable {
        case products
    }
    
    enum State: Equatable {
        case loading
        case loaded([ProductEntity])
        case error(message: String)
    }

    let dataProvider: DataProviderLogic
    
    var title = "Products"
    @Published var state: State
    
    /*
     Required for UICollectionView delegate pattern to be able to access the ProductEntity
     in order to push the Product Detail screen.
     */
    var products: [ProductEntity] = []
    
    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
        self.state = .loading
    }
    
    func fetchProducts() {
        dataProvider.fetchProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.products = response.productResponses?.map(ProductEntity.init) ?? []
                self.state = .loaded(self.products)
            case .failure(let error):
                self.state = .error(message: error.localizedDescription)
            }
        }
    }
}
