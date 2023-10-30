//
//  FavoriteViewModel.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation

class FavoriteListViewModel {
    var favoritesViewModel: [FavoriteViewModel]
    
    init() {
        self.favoritesViewModel = [FavoriteViewModel]()
    }
    
    func favoriteViewModel(at index: Int) -> FavoriteViewModel {
        return self.favoritesViewModel[index]
    }
    
    func numberOfItem() -> Int {
        return self.favoritesViewModel.count
    }
    
    func loadFavoriteItems() async throws {
        try await Webservice().load(resource: Item.getItems(), completion: { [weak self] result in
            switch result {
            case .success(let response):
                if let items = response.result.favoriteList {
                    for item in items {
                        self?.favoritesViewModel.append(FavoriteViewModel(favoriteItem: item))
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
}

class FavoriteViewModel {
    let item: Item
    var nickName: String
    var transType: TransType
    
    init(favoriteItem: Item) {
        self.item = favoriteItem
        self.nickName = favoriteItem.nickname
        self.transType = favoriteItem.transType
    }
}
