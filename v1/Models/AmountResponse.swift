//
//  USDResponse.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation


enum CurrencyType: String, Codable, CaseIterable {
    case USD
    case KHR
}


struct AmountResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: ResultList
}

struct ResultList: Codable {
    let savingsList: [Account]?
    let fixedDepositList: [Account]?
    let digitalList: [Account]?
    
}

struct Account: Codable {
    let account: String
    let curr: CurrencyType
    let balance: Double
}

extension Account {
    static func getSaving(type: CurrencyType, new: Bool = false) -> Resource<AmountResponse> {
        if new {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Savings2.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        } else {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Savings1.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        }
        
    }
    
    static func getFixed(type: CurrencyType, new: Bool = false) -> Resource<AmountResponse> {
        if new {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Fixed2.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        } else {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Fixed1.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        }
        
    }
    
    static func getDigital(type: CurrencyType, new: Bool = false) -> Resource<AmountResponse> {
        if new {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Digital2.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        } else {
            guard let url = URL(string: "https://willywu0201.github.io/data/\(type.rawValue.lowercased())Digital1.json") else {
                fatalError("URL is incorrect")
            }
            return Resource<AmountResponse>(url: url)
        }
        
    }
}
