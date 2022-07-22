//
//  LoremViewModel.swift
//  SAPDemoProject
//
//  Created by Apple on 21/07/22.
//

import UIKit

class LoremViewModel {
    
    private(set) var loremModel: [LoremModel]?
    var networkManager: NetworkManager

    init(networkM: NetworkManager = NetworkManager()) {
        self.networkManager = networkM
    }
    
    public func getData(completion: @escaping () -> ()) {
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
    
    var numberOfCells: Int {
        guard let loremCount = loremModel?.count else {
            return 0
        }
        return loremCount * 3
    }
    
    var loremTexts: [String] {
        var allText: [String] = []
        for loremM in loremModel ?? [] {
            allText.append(loremM.title)
            allText.append(loremM.description)
            allText.append(loremM.shortDescription)
        }
        return allText
    }
    
    private func calculatePercentage(value:Double,percentageVal:Double) -> Double{
        let val = value * percentageVal
        return val / 100.0
    }
    
    private func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {
        let font = UIFont(name: "Helvetica", size: 16.0)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    public func getCellHeight(index: Int, screenWidth: CGFloat) -> (width: CGFloat, height: CGFloat) {
        var width = 0.0
        if index == 1 || index%3 == 1 {
            width = calculatePercentage(value: screenWidth, percentageVal: 20.0)
        } else if index == 2 || index%3 == 2 {
            width = calculatePercentage(value: screenWidth, percentageVal: 48.9)
        } else {
            width = calculatePercentage(value: screenWidth, percentageVal: 30.0)
        }
        
        let text: String = self.loremTexts[index-1] 
        let height = requiredHeight(text: text, cellWidth: width)+16
        
        return (width, height)
    }
}
