//
//  KCCollectionViewController.swift
//  kevin
//
//  Created by kevin.cheng on 6/22/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class KCCollectionViewController: UIViewController {
    
    var itemTitles: [String] = ["Cholote", "Peanut", "Candy"]
    
    var numbers: [Float] = [0.1, 0.5, 0.4]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "BarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "verticalBarCell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
}

extension KCCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalBarCell", for: indexPath)
        
        if let barCell = cell as? BarCollectionViewCell {
            barCell.barTitleLabel.text = itemTitles[indexPath.row]
            barCell.barView.chartValue = numbers[indexPath.row]
        }
        return cell
    }
    
}

extension KCCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 150)
    }
}
