//
//  FavoriteResponse.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation

enum TransType: String, Codable {
    case CUBC
    case Mobile
    case PMF
    case CreditCard
}


struct FavoriteResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteList
}

struct FavoriteList: Codable {
    let favoriteList: [Item]?
}

struct Item: Codable {
    let nickname: String
    let transType: TransType
}

extension Item {
    
    static func getItems() -> Resource<FavoriteResponse> {
        guard let url = URL(string: "https://willywu0201.github.io/data/favoriteList.json") else {
            fatalError("URL is incorrect.")
        }
        return Resource<FavoriteResponse>(url: url)
    }
}
