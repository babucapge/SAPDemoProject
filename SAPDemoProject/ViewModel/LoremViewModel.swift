//
//  LoremViewModel.swift
//  SAPDemoProject
//
//  Created by Apple on 21/07/22.
//

import Foundation

class LoremViewModel {
    
    var loremModel: [LoremModel]?
    var networkManager: NetworkManager
    
    init(networkM: NetworkManager = NetworkManager()) {
        self.networkManager = networkM
    }
    
    func getData(completion: @escaping () -> ()) {
        self.networkManager.parseJsonFile(name: "Lorem", completion: { (result: Result<[LoremModel], ParseError>) in
            switch result {
            case .success(let successValue):
                self.loremModel = successValue
            case .failure(let error):
                print(error)
            }
        })
        completion()
    }
}
