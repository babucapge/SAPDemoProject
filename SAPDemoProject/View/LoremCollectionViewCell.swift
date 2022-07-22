//
//  LoremCollectionViewCell.swift
//  SAPDemoProject
//
//  Created by Apple on 21/07/22.
//

import UIKit

class LoremCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var lblTitle: UILabel!
    
    static let identifier = "loremCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "LoremCollectionViewCell", bundle: nil)
    }
    
    func configureData(text: String) {
        self.lblTitle.text = text
    }
}
