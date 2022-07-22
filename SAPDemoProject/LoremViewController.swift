//
//  ViewController.swift
//  SAPDemoProject
//
//  Created by Apple on 20/07/22.
//

import UIKit

class LoremViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var loremVM: LoremViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loremVM = LoremViewModel()
        getDataFromJson()
        setupUI()
    }
    
    private func setupUI() {
        self.collectionView.register(LoremCollectionViewCell.nib(), forCellWithReuseIdentifier: LoremCollectionViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    private func getDataFromJson() {
        self.loremVM?.getData(completion: { [weak self] in
            //Render colleciton view
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
}
            
extension LoremViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.loremVM?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loremCell", for: indexPath) as! LoremCollectionViewCell
        cell.configureData(text: self.loremVM?.loremTexts[indexPath.row] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.loremVM?.getCellHeight(index: indexPath.row+1, screenWidth: self.view.frame.size.width)
        return CGSize(width: size?.width ?? 0.0, height: size?.height ?? 0.0)
    }
}
