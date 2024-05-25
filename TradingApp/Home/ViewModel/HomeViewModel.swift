//
//  HomeViewModel.swift
//  TradingApp
//
//  Created by Vinod Gupta on 23/05/24.
//

import Foundation

enum ViewModelState {
    case loading
    case loaded
}

class HomeViewModel {
    var state: ViewModelState = .loaded {
        didSet {
            apiStateUpdated?()
        }
    }
    var holdings: [UserHolding] = [] {
        didSet {
            holdingsUpdated?()
        }
    }
    var error: String?
    
    var holdingsUpdated: (() -> Void)?
    var apiStateUpdated: (() -> Void)?
    
    func getHoldings() {
        self.state = .loading
        ServiceManager.shared.getRequest(endpoint: .holdings, responseModel: HoldingsModel.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.holdings = response.data?.userHolding ?? []
            case .failure(let error):
                print(error.localizedDescription, error.rawValue)
                self?.error = error.rawValue
            }
            self?.state = .loaded
        }
    }
}
