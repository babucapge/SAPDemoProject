//
//  ViewController.swift
//  SAPDemoProject
//
//  Created by Apple on 20/07/22.
//

import UIKit

class ViewController: UIViewController {

    var loremVM: LoremViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loremVM = LoremViewModel()
        getDataFromJson()
    }
    
    private func getDataFromJson() {
        self.loremVM?.getData(completion: { [weak self] in
            //Render colleciton view
        })
    }
}


