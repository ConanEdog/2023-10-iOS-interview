//
//  AccountViewModel.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation

class AccountListViewModel {
    private(set) var accountsViewModel = [AccountViewModel]()
    
    private func addAccountVM(_ vm: AccountViewModel) {
        accountsViewModel.append(vm)
    }
    
    func getAccountVM(_ new: Bool = false) async throws {
        
        self.accountsViewModel.removeAll()
        
        try await Webservice().load(resource: Account.getSaving(type: .USD, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.savingsList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        try await  Webservice().load(resource: Account.getFixed(type: .USD, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.fixedDepositList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        try await Webservice().load(resource: Account.getDigital(type: .USD, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.digitalList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        try await Webservice().load(resource: Account.getSaving(type: .KHR, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.savingsList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        try await Webservice().load(resource: Account.getFixed(type: .KHR, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.fixedDepositList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        try await Webservice().load(resource: Account.getDigital(type: .KHR, new: new)) { [weak self] result in
            switch result {
            case .success(let response):
                //print(response)
                guard let accounts = response.result.digitalList else {
                    fatalError("Can not get accounts")
                }
                for account in accounts {
                    self?.addAccountVM(AccountViewModel(account: account))
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func getTotalBalance(currency: CurrencyType) -> Double {
        
        
        var totalBalance = 0.0
        
        let sameCurrAccounts = accountsViewModel.filter({ vm in
            return vm.currency == currency
        })
        
        for vm in sameCurrAccounts {
            totalBalance += vm.balance
        }
        return totalBalance
    }
        
}


class AccountViewModel {
    let account: Account
    var currency: CurrencyType
    var balance: Double

    init(account: Account) {
        self.account = account
        self.currency = account.curr
        self.balance = account.balance
    }
}


