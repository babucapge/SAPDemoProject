//
//  ViewController.swift
//  SAPDemoProject
//
//  Created by Apple on 20/07/22.
//

import UIKit

class LoremViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var loremVM: LoremViewModel?

    private var scale: CGFloat = 0.0 {
        didSet {
            if scale < kScaleBoundLower {
                scale = kScaleBoundLower;
            }
            else if scale > kScaleBoundUpper {
                scale = kScaleBoundUpper;
            }
        }
    }
    private var fitCells = true
    private var animatedZooming: Bool?
    private var scaleStart: CGFloat?
    private let kScaleBoundLower: CGFloat = 0.5
    private let kScaleBoundUpper: CGFloat = 2.0
    
    private var gesture = UIPinchGestureRecognizer()
    
    
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
        
        self.animatedZooming = false
        self.scale = (kScaleBoundUpper + kScaleBoundLower)/2.0;
    
        self.gesture.delegate = self
        self.gesture = UIPinchGestureRecognizer(target: self, action:#selector(self.didReceivePinchGesture(gesture:)))
        self.collectionView.addGestureRecognizer(self.gesture)
    }
    
    private func getDataFromJson() {
        self.loremVM?.getData(completion: { [weak self] in
            //Render colleciton view
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
    
    @objc private func didReceivePinchGesture(gesture: UIPinchGestureRecognizer) {
        self.fitCells = false
        if gesture.state == .began {
            scaleStart = self.scale
            return
        }
        
        if gesture.state == .changed {
            self.scale = scaleStart!*gesture.scale
            if self.animatedZooming ?? true {
                self.collectionView.removeGestureRecognizer(self.gesture)
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                self.collectionView.setCollectionViewLayout(layout, animated: true) { finished in
                    self.collectionView.addGestureRecognizer(self.gesture)
                }
            } else {
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        }
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
        let scaledWidth = 50 * self.scale
        if self.fitCells {
            return CGSize(width: size?.width ?? 0.0, height: size?.height ?? 0.0)
        }
        return CGSize(width: size?.width ?? 0.0, height: scaledWidth+scaledWidth)
    }
}
